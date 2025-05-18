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
#include <cfenv>    // set rounding mode
#pragma STDC FENV_ACCESS ON // enable access to floating-point environment

using namespace std;

const int   PATTERN_NUM = 100;
const int   INPUT_DIM   = 4;
const int   HIDDEN_DIM  = 3;
const float INITIAL_LR  = 0.000001f;
const int   EPOCHS      = 25;
const int   DATA_SIZE   = 100;

inline float flush_denormals_to_zero(float f) {
    if (std::fpclassify(f) == FP_SUBNORMAL) {
        return std::signbit(f) ? -0.0f : +0.0f;
    }
    return f;
}

inline float nan_to_inf(float f) {
    if (std::isnan(f)) {
        return std::signbit(f) ? -INFINITY : +INFINITY;
    }
    return f;
}

float preprocess(float f) {
    f = flush_denormals_to_zero(f);
    f = nan_to_inf(f);
    return f;
}

float sanitize_for_dw(float f) {
    if (std::isnan(f)) {
        return std::signbit(f) ? -INFINITY : INFINITY;
    } else if (std::fpclassify(f) == FP_SUBNORMAL) {
        return std::signbit(f) ? -0.0f : 0.0f;
    } else {
        return f;
    }
}

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
            z1[i] += preprocess(w1[i][j] * x[j]);
            z1[i] = preprocess(z1[i]);
        }
        a1[i] = relu(z1[i]);
    }

    // Output layer
    float out = 0;
    for (int i = 0; i < HIDDEN_DIM; i++) {
        out += preprocess(w2[i] * a1[i]);
        out = preprocess(out);
    }

    return out;
}

void backward(float pred, float y, const float x[INPUT_DIM],
              const float z1[HIDDEN_DIM], const float a1[HIDDEN_DIM],
              float w1[HIDDEN_DIM][INPUT_DIM], float w2[HIDDEN_DIM],
              float lr) {
    float dL_dy = preprocess(pred - y);

    // Gradients for output layer
    for (int i = 0; i < HIDDEN_DIM; i++) {
        float d_out = preprocess(dL_dy * a1[i]);
        w2[i] -= preprocess(lr * d_out);
        w2[i] = preprocess(w2[i]);
    }

    // Gradients for hidden layer
    for (int i = 0; i < HIDDEN_DIM; i++) {
        float d_relu = relu_derivative(z1[i]) * preprocess(w2[i] * dL_dy);
        d_relu = preprocess(d_relu);
        for (int j = 0; j < INPUT_DIM; j++) {
            w1[i][j] -= preprocess(lr * preprocess(d_relu * x[j]));
            w1[i][j] = preprocess(w1[i][j]);
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
    string s = ss.str();
    return s;
    // return (s == "80000000" ? "00000000" : s);
}

float generate_random_float(float bound) {
    // Generate a random float in the range [-bound, bound]
    return static_cast<float>(rand()) / RAND_MAX * 2 * bound - bound;
}

int main() {
    if (fesetround(FE_TONEAREST) != 0) { // Set rounding mode to nearest even (i.e., rnd of 000 in DW)
        std::cerr << "Failed to set rounding mode!" << std::endl;
        return 1;
    }
    // srand(10531615); // Seed for reproducibility
    // srand(10531616); // Seed for reproducibility
    srand(time(0)); // Random seed for different runs

    for (int i = 0; i < PATTERN_NUM; i++) {
        // Random training data
        vector<Sample> data(DATA_SIZE);
        for (int i = 0; i < DATA_SIZE; i++) {
            for (int j = 0; j < INPUT_DIM; j++) {
                data[i].x[j] = generate_random_float(0.1f);  // [-0.1, 0.1]
                // data[i].x[j] = ((float)rand() / RAND_MAX) * 0.01f; // [-0.01, 0.01]
            }
            data[i].y = generate_random_float(0.1f);    // [-0.1, 0.1]
            // data[i].y = ((float)rand() / RAND_MAX) * 0.01f; // [-0.01, 0.01]
        }

        for (int epoch = 0; epoch < EPOCHS; epoch++) {
            for (int i = 0; i < DATA_SIZE; i++) {
                for (int j = 0; j < INPUT_DIM; j++) 
                    fin << float_to_hex(data[i].x[j]) << endl;  // [-1, 1]
                ft << float_to_hex(data[i].y) << endl;  // [-1, 1]
            }
        }

        // Initialize weights
        float w1[HIDDEN_DIM][INPUT_DIM];
        float w2[HIDDEN_DIM];
        for (int i = 0; i < HIDDEN_DIM; i++) {
            for (int j = 0; j < INPUT_DIM; j++)
                fw1 << float_to_hex(w1[i][j] = generate_random_float(0.01f)) << endl; // [-0.01, 0.01]
            fw2 << float_to_hex(w2[i] = generate_random_float(0.01f)) << endl; // [-0.01, 0.01]
        }

        // Training
        for (int epoch = 0; epoch < EPOCHS; epoch++) {
            float lr = INITIAL_LR * pow(0.5f, epoch / 4); // decay every 4 epochs
            cout << "LR: " << lr << ", hex: " << float_to_hex(lr) << endl;
            for (int i = 0; i < DATA_SIZE; i++) {
                Sample& s = data[i];
                float z1[HIDDEN_DIM], a1[HIDDEN_DIM];
                float pred = forward(s.x, w1, w2, z1, a1);
                fout << float_to_hex(pred) << endl;
                float error = abs((s.y - pred) / s.y);

                cout << std::scientific << std::setprecision(4) << " Epoch " << epoch << " Sample " << i
                    << " | Pred: " <<  pred
                    << " | Error: " << error << endl;

                backward(pred, s.y, s.x, z1, a1, w1, w2, lr);
            }
        }
    }
    return 0;
}
