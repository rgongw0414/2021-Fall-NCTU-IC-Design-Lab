#include <iostream>
#include <vector>
#include <algorithm>
#include <ctime>
#include <cstdlib>
#include <fstream>

using namespace std;

ofstream test_in("test_in_ignore.txt");
ofstream test_out("test_out_ignore.txt");
const int N = 5;
const int TOTAL_MOVES = N * N;
const int dx[8] = {-1, 1, 2,  2,  1, -1, -2, -2};
const int dy[8] = { 2, 2, 1, -1, -2, -2, -1,  1};
int TEST_CASES = 10000;
int move_num = 0;
int priority_num = 0;
bool flag = true;
vector<pair<int, int>> in_coor;

bool is_valid(int x, int y, vector<vector<int>>& board) {
    return x >= 0 && x < N && y >= 0 && y < N && board[x][y] == -1;
}

bool knight_tour(int x, int y, int movei, vector<vector<int>>& board) {
    if (movei == TOTAL_MOVES) return true;
    if (in_coor.size() < move_num) {
        in_coor.push_back({x, y});
        flag = false;
    }
    for (int k = priority_num, count = 0; count < 8; k = (k + 1) % 8, count++) {
        int nx = x + dx[k];
        int ny = y + dy[k];
        if (is_valid(nx, ny, board)) {
            board[nx][ny] = movei;
            if (knight_tour(nx, ny, movei + 1, board)) return true;
            board[nx][ny] = -1;  // backtrack
        }
    }
    return false;
}

void print_board(const vector<vector<int>>& board) {
    // test_in << "move_num: " << move_num << ", priority_num: " << priority_num << endl;
    test_in << move_num << " " << priority_num << endl;
    for (const auto& p : in_coor) {
        test_in << p.first << " " << p.second << endl;
    }
    vector<pair<int, int>> moves(TOTAL_MOVES);
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            moves[board[i][j]] = {i, j};
        }
    }

    for (const auto& p : moves)
        test_out << p.first << " " << p.second << endl;
}

int main() {
    srand(time(0));
    int found = 0;
    while (found < TEST_CASES) {
        flag = true;
        int sx = rand() % N;
        int sy = rand() % N;
        move_num = rand() % 25 + 1;
        priority_num = rand() % 8;
        vector<vector<int>> board(N, vector<int>(N, -1));
        board[sx][sy] = 0;
        if (knight_tour(sx, sy, 1, board)) {
            print_board(board);
            found++;
        }
        in_coor.clear();
    }
    return 0;
}
