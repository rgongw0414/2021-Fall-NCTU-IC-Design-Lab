#include <bits/stdc++.h>
using namespace std;

const int PAT_NUM = 100;
const int DATA_NUM = 100;
const int EPOCH_NUM = 25;
const int INPUT_DIM = 4;
ofstream fin("input_ignore.txt");
ofstream ft("target_ignore.txt");
ofstream fw("weight_ignore.txt");
ofstream fout("output_ignore.txt");

// float forward(const vector<vector<float>>& inputs, const int i, const vector<float>& weights) {
//     /* ANN structure (biases are ignored):
//      * 4 inputs (s0 to s3)
//      * 1 hidden layer with 3 neurons (h0 to h2)
//      * 1 output layer with 1 neuron (o0)
//      * 4 * 3 + 3 * 1 = 15 weights */

//     // Input layer
//     float y0 = inputs[i][0] * weights[0] + inputs[i][1] * weights[1] + inputs[i][2] * weights[2] + inputs[i][3] * weights[3];
//     float y1 = inputs[i][0] * weights[4] + inputs[i][1] * weights[5] + inputs[i][2] * weights[6] + inputs[i][3] * weights[7];
//     float y2 = inputs[i][0] * weights[8] + inputs[i][1] * weights[9] + inputs[i][2] * weights[10] + inputs[i][3] * weights[11];
    
//     // Activation function (ReLU)
//     float h0 = max(0.0f, y0);
//     float h1 = max(0.0f, y1);
//     float h2 = max(0.0f, y2);

//     // Output layer
//     float o0 = h0 * weights[12] + h1 * weights[13] + h2 * weights[14];
//     fout << o0 << endl;
//     return o0;
// }

// void backward(const vector<vector<float>>& inputs, int i, const vector<float>& weights, const float y_pred, const float y_gold, const float learning_rate = 0.000001) {
//     // Backward pass (gradient descent)
//     // Calculate the gradients and update the weights

//     // Output layer weights update
//     float error = y_pred - y_gold;
//     weights[12] -= learning_rate * error * inputs[i][0];
//     weights[13] -= learning_rate * error * inputs[i][1];
//     weights[14] -= learning_rate * error * inputs[i][2];
//     // Hidden layer weights update
//     for (int j = 0; j < 3; j++) {
//         float h = (j == 0) ? inputs[i][0] : (j == 1) ? inputs[i][1] : inputs[i][2];
//         float gradient = error * weights[12 + j] * (h > 0 ? 1 : 0); // ReLU derivative
//         weights[j * 4] -= learning_rate * gradient * inputs[i][0];
//         weights[j * 4 + 1] -= learning_rate * gradient * inputs[i][1];
//         weights[j * 4 + 2] -= learning_rate * gradient * inputs[i][2];
//         weights[j * 4 + 3] -= learning_rate * gradient * inputs[i][3];
//     }
//     // Note: In a real implementation, you would need to update the weights in a way that persists across iterations.
//     // This is a simplified version for demonstration purposes.
// }

int main() {
    // srand(10531615); // Seed for reproducibility
    
    // Create random number generator
    std::random_device rd;
    std::mt19937 gen(rd());


    // Define distribution within IEEE 754 float range
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);

    // Generate a random float
    // float randomFloat = dist(gen);
    // std::cout << "Random IEEE 754 float: " << randomFloat << std::endl;
    // return 0;


    // Each epoch has 100 inputs and 15 weights
    for (int i = 0; i < PAT_NUM; i++) {
        // Generate random input, weights and target
        vector<vector<float>> inputs(DATA_NUM, vector<float>(INPUT_DIM, static_cast<float>(dist(gen)))); // s0 to s3
        vector<float> targets(DATA_NUM); // the target of 25 epochs training
        for (int i = 0; i < DATA_NUM; i++) {
            for (const float& val : inputs[i]) {
                fin << val << endl;
            }
            targets[i] = static_cast<float>(dist(gen)); // Random target
            ft << targets[i] << endl; // Output the target of current data (inputs[i])
        }
        vector<float> weights(15, static_cast<float>(dist(gen))); // w0 to w14
        for (const float& weight : weights) fw << weight << endl;

        float learning_rate = 0.000001;
        for (int epoch = 0; epoch < EPOCH_NUM; epoch++) { // Train the network for 25 epochs
            float error = 0.0f;
            for (int i = 0; i < DATA_NUM; i++) {
                // Forward pass
                // Input layer
                float h0 = inputs[i][0] * weights[0] + inputs[i][1] * weights[1] + inputs[i][2] * weights[2] + inputs[i][3] * weights[3];
                float h1 = inputs[i][0] * weights[4] + inputs[i][1] * weights[5] + inputs[i][2] * weights[6] + inputs[i][3] * weights[7];
                float h2 = inputs[i][0] * weights[8] + inputs[i][1] * weights[9] + inputs[i][2] * weights[10] + inputs[i][3] * weights[11];
                
                // Activation function (ReLU)
                float y0 = max(0.0f, h0);
                float y1 = max(0.0f, h1);
                float y2 = max(0.0f, h2);

                // Output layer
                float y_pred = y0 * weights[12] + y1 * weights[13] + y2 * weights[14];
                fout << y_pred << endl;
                
                // Calculate the error
                float y_gold = targets[i]; // Define y_gold here
                // error = y_pred - y_gold;
                error = sqrt((y_pred - y_gold)*(y_pred - y_gold));

                // Each 4 epochs, LR will be reduced to half of the original
                if (epoch % 4 == 0 && epoch > 0) learning_rate /= 2;

                // Backward: Update the weights (gradient descent)
                // Output layer weights update
                weights[12] -= learning_rate * error * y0;
                weights[13] -= learning_rate * error * y1;
                weights[14] -= learning_rate * error * y2;
                // backward(inputs, i, weights, y_pred, y_gold, learning_rate);

                // Hidden layer weights update
                for (int j = 0; j < 3; j++) {
                    float h = (j == 0) ? h0 : (j == 1) ? h1 : h2;
                    float gradient = error * weights[12 + j] * (h > 0 ? 1 : 0); // ReLU derivative
                    weights[j * 4]     -= learning_rate * gradient * inputs[i][0];
                    weights[j * 4 + 1] -= learning_rate * gradient * inputs[i][1];
                    weights[j * 4 + 2] -= learning_rate * gradient * inputs[i][2];
                    weights[j * 4 + 3] -= learning_rate * gradient * inputs[i][3];
                }
                // Note: In a real implementation, you would need to update the weights in a way that persists across iterations.
                // This is a simplified version for demonstration purposes.
                // backward(inputs, i, weights, y_pred, y_gold, learning_rate);

            }
            cout << "epoch " << epoch << " error: " << error << endl;
            // if (epoch == 0 || epoch == 24) cout << "epoch " << epoch << " error: " << error << endl;
        }
    }

}