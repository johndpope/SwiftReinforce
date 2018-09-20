import matplotlib
matplotlib.use('tkAgg')
import numpy as np
import torch
import torch.nn as nn
import torch.utils.data

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


class Net(nn.Module):
    def __init__(self, input_size, hidden_size, num_out):
        super(Net, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size)
        self.sigmoid = nn.Sigmoid()
        self.fc2 = nn.Linear(hidden_size, num_out)

    def forward(self, x):
        out = self.fc1(x)
        out = self.sigmoid(out)
        out = self.fc2(out)
        return out


def gen_train_image(angle, side, thickness):
    image = np.zeros((side, side))
    (x_0, y_0) = (side / 2, side / 2)
    (c, s) = (np.cos(angle), np.sin(angle))
    for y in range(side):
        for x in range(side):
            if (abs((x - x_0) * c + (y - y_0) * s) < thickness / 2) and (
                    -(x - x_0) * s + (y - y_0) * c > 0):
                image[x, y] = 1

    return image.flatten()


def gen_data(num_samples, side, num_bins, thickness):
    angles = 2 * np.pi * np.random.uniform(size=num_samples)
    X = [gen_train_image(angle, side, thickness) for angle in angles]
    X = np.stack(X)

    y = {"cos_sin": [], "binned": []}
    bin_size = 2 * np.pi / num_bins
    for angle in angles:
        idx = int(angle / bin_size)
        y["binned"].append(idx)
        y["cos_sin"].append(np.array([np.cos(angle), np.sin(angle)]))

    for enc in y:
        y[enc] = np.stack(y[enc])

    return (X, y, angles)


def get_model_stuff(train_y, input_size, hidden_size, output_sizes,
                    learning_rate, momentum):
    nets = {}
    optimizers = {}

    for enc in train_y:
        net = Net(input_size, hidden_size, output_sizes[enc])
        nets[enc] = net.to(device)
        optimizers[enc] = torch.optim.SGD(net.parameters(), lr=learning_rate,
                                          momentum=momentum)

    criterions = {"binned": nn.CrossEntropyLoss(), "cos_sin": nn.MSELoss()}
    return (nets, optimizers, criterions)


def get_train_loaders(train_X, train_y, batch_size):
    train_X_tensor = torch.Tensor(train_X)

    train_loaders = {}

    for enc in train_y:
        if enc == "binned":
            train_y_tensor = torch.tensor(train_y[enc], dtype=torch.long)
        else:
            train_y_tensor = torch.tensor(train_y[enc], dtype=torch.float)

        dataset = torch.utils.data.TensorDataset(train_X_tensor, train_y_tensor)
        train_loader = torch.utils.data.DataLoader(dataset=dataset,
                                                   batch_size=batch_size,
                                                   shuffle=True)
        train_loaders[enc] = train_loader

    return train_loaders


def show_image(image, side):
    img = plt.imshow(np.reshape(image, (side, side)), interpolation="nearest",cmap="Greys")
    plt.show()


def main():
    side = 101
    input_size = side ** 2
    thickness = 5.0
    hidden_size = 500
    learning_rate = 0.01
    momentum = 0.9
    num_bins = 500
    bin_size = 2 * np.pi / num_bins
    half_bin_size = bin_size / 2
    batch_size = 50
    output_sizes = {"binned": num_bins, "cos_sin": 2}
    num_test = 1000

    (test_X, test_y, test_angles) = gen_data(num_test, side, num_bins,
                                             thickness)

    for num_train in [100, 1000]:

        (train_X, train_y, train_angles) = gen_data(num_train, side, num_bins,thickness)
        train_loaders = get_train_loaders(train_X, train_y, batch_size)

        for epochs in [100, 500]:

            (nets, optimizers, criterions) = get_model_stuff(train_y, input_size,
                                                             hidden_size, output_sizes,
                                                             learning_rate, momentum)

            for enc in train_y:
                optimizer = optimizers[enc]
                net = nets[enc]
                criterion = criterions[enc]

                for epoch in range(epochs):
                    for (i, (images, ys)) in enumerate(train_loaders[enc]):
                        optimizer.zero_grad()

                        outputs = net(images.to(device))
                        loss = criterion(outputs, ys.to(device))
                        loss.backward()
                        optimizer.step()


            print("Training Size: {0}".format(num_train))
            print("Training Epochs: {0}".format(epochs))
            for enc in train_y:
                net = nets[enc]
                preds = net(torch.tensor(test_X, dtype=torch.float).to(device))
                if enc == "binned":
                    pred_bins = np.array(preds.argmax(dim=1).detach().cpu().numpy(),dtype=np.float)
                    pred_angles = bin_size * pred_bins + half_bin_size
                else:
                    pred_angles = torch.atan2(preds[:, 1], preds[:, 0]).detach().cpu().numpy()
                    pred_angles[pred_angles < 0] = pred_angles[pred_angles < 0] + 2 * np.pi

                print("Encoding: {0}".format(enc))
                print("Test Error: {0}".format(np.abs(pred_angles - test_angles).mean()))

            print()


if __name__ == "__main__":
    main()