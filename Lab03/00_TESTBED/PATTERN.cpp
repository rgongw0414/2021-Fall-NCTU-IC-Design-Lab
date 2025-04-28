#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>
#include <ctime>
#include <cstdlib>
#include <fstream>
#include <utility>
#include <queue>
#include <unordered_map>

using namespace std;

const int PATTERN_NUM = 500; // Number of patterns
const int N = 17; // Maze size (17x17)
const int MIN_STEPS = 64; // The minimum steps to consider a valid answer of a maze
ofstream test_in("input_ignore.txt");
ofstream test_in_formated("input_formated_ignore.txt");
ofstream test_out("output_ignore.txt");

bool isValid(int x, int y) {
    return x >= 0 && x < N && y >= 0 && y < N;
}

void generateMaze(vector<vector<int>> &maze, int startX, int startY) {
    // Directions: up, down, left, right
    const int dx[] = { -2, 2, 0, 0 };
    const int dy[] = { 0, 0, -2, 2 };

    stack<pair<int, int>> s;
    s.push({startX, startY});
    maze[startX][startY] = 1; // Start point is path

    while (!s.empty()) {
        int x = s.top().first;
        int y = s.top().second;

        // Find unvisited neighbors
        vector<int> dirs = {0, 1, 2, 3};
        random_shuffle(dirs.begin(), dirs.end());

        bool moved = false;
        for (int i = 0; i < 4; i++) {
            int nx = x + dx[dirs[i]];
            int ny = y + dy[dirs[i]];

            if (isValid(nx, ny) && maze[nx][ny] == 0) {
                // Knock down wall between (x,y) and (nx,ny)
                maze[(x + nx) / 2][(y + ny) / 2] = 1;
                maze[nx][ny] = 1; // Mark as path
                s.push({nx, ny});
                moved = true;
                break;
            }
        }

        if (!moved) {
            s.pop(); // Backtrack
        }
    }
}

void printMaze(vector<vector<int>> &maze) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            test_in_formated << maze[i][j] << " "; 
            test_in << maze[i][j]; 
        }
        test_in_formated << endl;
    }
    test_in << endl; 
}

std::unordered_map<int, std::unordered_map<int, char>> arrow_map = {
    {-1, {{0, '^'}}}, 
    {1, {{0, 'v'}}}, 
    {0, {{-1, '<'}, {1, '>'}}}, 
    {-1, {{-1, '0'}}}
};

vector<pair<int, int>> buildPath(vector<vector<pair<int, int>>> &parents) {
    vector<pair<int, int>> path;
    pair<int, int> current = {N - 1, N - 1}; // Start from the end
    int steps = 0;
    while (current != make_pair(0, 0)) {
        int dx = current.first - parents[current.first][current.second].first; 
        int dy = current.second - parents[current.first][current.second].second;
        // test_out << arrow_map[dx][dy] << " ";
        path.push_back(current);
        current = parents[current.first][current.second];
        steps++;
    }
    reverse(path.begin(), path.end());
    return path;
}

vector<vector<pair<int, int>>> solveMaze(vector<vector<int>> &maze, int startX, int startY) {
    // Implement a maze-solving algorithm here if needed
    queue<pair<int, int>> q;
    vector<vector<pair<int, int>>> parents(N, vector<pair<int, int>>(N, {-1, -1})); // -1 for not visited
    q.push({startX, startY});
    parents[startX][startY] = {0, 0};
    
    // Directions: up, down, left, right
    const int dx[] = { -1, 1,  0, 0 };
    const int dy[] = {  0, 0, -1, 1 };
    while (!q.empty()) {
        int x = q.front().first;
        int y = q.front().second;
        q.pop();
        if (x == N - 1 && y == N - 1) {
            // for (int i = 0; i < N; i++) {
            //     for (int j = 0; j < N; j++) {
            //         // test_out << "(" << parents[i][j].first << "," << parents[i][j].second << ") ";
            //         if (maze[i][j] == 1) {
            //             if (parents[i][j] == make_pair(-1, -1)) test_out << "1 ";
            //             else test_out << arrow_map[i - parents[i][j].first][j - parents[i][j].second] << " ";
            //         }
            //         else {
            //             test_out << "0 ";
            //         }
            //     }
            //     test_out << endl;
            // }
            // vector<pair<int, int>> path = buildPath(parents);
            // int steps = path.size();
            // test_out << "Path found with " << steps << " steps: ";
            // for (const auto &p : path) {
            //     int dx = p.first - parents[p.first][p.second].first; 
            //     int dy = p.second - parents[p.first][p.second].second;
            //     test_out << arrow_map[dx][dy];
            // }
            // test_out << endl;
            return parents; 
        }

        // Check all 4 directions
        for (int dir = 0; dir < 4; dir++) {
            int nx = x + dx[dir];
            int ny = y + dy[dir];

            if (isValid(nx, ny)) {
                // if (nx == 0 && ny == 0) {
                //     continue; // Skip the start point
                // }
                if (maze[nx][ny] == 1 && parents[nx][ny] == make_pair(-1, -1)) {
                    parents[nx][ny] = {x, y}; // Mark the parent of (nx, ny), also it's visited
                    q.push({nx, ny});
                } 
            }
        }
    }
    test_out << "Failed to find the answer" << endl;
    return {}; // No path found
}

int main() {
    /*
    TODO: Generate cases with loops and cycles
    */
    // srand(time(0)); // Seed random number generator
    srand(10531615); // Fixed seed for reproducibility
    int found = 0;
    while (found < PATTERN_NUM) {
        // cout << "Pattern " << _ + 1 << ":" << endl;
        vector<vector<int>> maze(N, vector<int>(N, 0)); // 0 = Wall, 1 = Path
        generateMaze(maze, 0, 0);
        // auto copyMaze = maze; // Copy the maze for the next step
        // for (int r = 0; r < N; r++) {
        //     for (int c = 0; c < N; c++) { // Fixed the loop variable from 'k' to 'c'
        //         if (maze[r][c] == 0 && r % 2 == 0 && c % 2 == 0) { // Changed 'j' to 'r' for consistency
        //             maze[r][c] = 1;
        //         }
        //     }
        // }
        // if (copyMaze == maze) found++;
        auto parents = solveMaze(maze, 0, 0); // Call the maze-solving function
        vector<pair<int, int>> path = buildPath(parents);
        if (path.size() >= MIN_STEPS) {
            test_in_formated << "Pattern " << found + 1 << ":" << endl;
            printMaze(maze);
            int steps = path.size();
            test_out << "Path found with " << steps << " steps: ";
            for (const auto &p : path) {
                int dx = p.first - parents[p.first][p.second].first; 
                int dy = p.second - parents[p.first][p.second].second;
                test_out << arrow_map[dx][dy];
            }
            test_out << endl;
            found++;
        }
    }
    return 0;
}
