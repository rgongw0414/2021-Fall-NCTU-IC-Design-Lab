#include <iostream>
#include <vector>
#include <cmath>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <random>
#include <iomanip>  // for std::setw and std::setfill
#include <cstring>  // for std::memcpy
#include <sstream>  // for std::stringstream
#include <cstdint>  // for std::uint32_t
#include <string>

using namespace std;

const int PATTERN_NUM = 250;
const int INPUT_DIM = 4;
const int HIDDEN_DIM = 3;
const float INITIAL_LR = 0.000001f;
const int EPOCHS = 25;
const int DATA_SIZE = 100;

struct Sample {
    float x[INPUT_DIM];
    float y; // ground truth
};

float relu(float x) {
    return x > 0 ? x : 0;
}

float relu_derivative(float x) {
    return x > 0 ? 1.0f : 0.0f;
}

float forward(const float x[INPUT_DIM], const float w1[HIDDEN_DIM][INPUT_DIM], const float w2[HIDDEN_DIM],
              float z1[HIDDEN_DIM], float a1[HIDDEN_DIM]) {
    // Hidden layer
    for (int i = 0; i < HIDDEN_DIM; i++) {
        z1[i] = 0;
        for (int j = 0; j < INPUT_DIM; j++) {
            z1[i] += w1[i][j] * x[j];
        }
        a1[i] = relu(z1[i]);
    }

    // Output layer
    float out = 0;
    for (int i = 0; i < HIDDEN_DIM; i++) {
        out += w2[i] * a1[i];
    }

    return out;
}

void backward(float pred, float y, const float x[INPUT_DIM],
              const float z1[HIDDEN_DIM], const float a1[HIDDEN_DIM],
              float w1[HIDDEN_DIM][INPUT_DIM], float w2[HIDDEN_DIM],
              float lr) {
    float dL_dy = pred - y;

    // Gradients for output layer
    for (int i = 0; i < HIDDEN_DIM; i++) {
        float d_out = dL_dy * a1[i];
        w2[i] -= lr * d_out;
    }

    // Gradients for hidden layer
    for (int i = 0; i < HIDDEN_DIM; i++) {
        float d_relu = relu_derivative(z1[i]) * w2[i] * dL_dy;
        for (int j = 0; j < INPUT_DIM; j++) {
            w1[i][j] -= lr * d_relu * x[j];
        }
    }
}

ofstream fin("input_ignore.txt");
ofstream ft("target_ignore.txt");
ofstream fw1("weight1_ignore.txt");
ofstream fw2("weight2_ignore.txt");
ofstream fout("output_ignore.txt");

// Convert float to IEEE-754 32-bit hex
std::string float_to_hex(float f) {
    uint32_t bits;
    std::memcpy(&bits, &f, sizeof(bits));
    std::stringstream ss;
    ss << std::hex << std::setw(8) << std::setfill('0') << bits;
    return ss.str();
}

int main() {
    srand(10531615); // Seed for reproducibility
    // srand(time(0)); // Random seed for different runs

    for (int i = 0; i < PATTERN_NUM; i++) {
        // Random training data
        vector<Sample> data(DATA_SIZE);
        for (int i = 0; i < DATA_SIZE; i++) {
            for (int j = 0; j < INPUT_DIM; j++) 
                fin << float_to_hex(data[i].x[j] = ((float)rand() / RAND_MAX) * 2 - 1) << endl;  // [-1, 1]
            ft << float_to_hex(data[i].y = ((float)rand() / RAND_MAX) * 2 - 1) << endl;  // [-1, 1]
        }

        // Initialize weights
        float w1[HIDDEN_DIM][INPUT_DIM];
        float w2[HIDDEN_DIM];
        for (int i = 0; i < HIDDEN_DIM; i++) {
            for (int j = 0; j < INPUT_DIM; j++)
                fw1 << float_to_hex(w1[i][j] = ((float)rand() / RAND_MAX) * 0.01f) << endl; // [-0.01, 0.01]
            fw2 << float_to_hex(w2[i] = ((float)rand() / RAND_MAX) * 0.01f) << endl; // [-0.01, 0.01]
        }

        // Training
        for (int i = 0; i < DATA_SIZE; i++) {
            Sample& s = data[i];
            for (int epoch = 0; epoch < EPOCHS; epoch++) {
                float lr = INITIAL_LR * pow(0.5f, epoch / 4); // decay every 4 epochs

                float z1[HIDDEN_DIM], a1[HIDDEN_DIM];
                float pred = forward(s.x, w1, w2, z1, a1);
                fout << float_to_hex(pred) << endl;
                float error = pred - s.y;

                // cout << "Sample " << i << " Epoch " << epoch
                //     << " | Pred: " << pred
                //     << " | Error: " << error << endl;

                backward(pred, s.y, s.x, z1, a1, w1, w2, lr);
            }
        }
    }
    return 0;
}
