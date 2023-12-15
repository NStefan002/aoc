#include <iostream>
#include <fstream>
#include <cctype>
#include <string>
#include <vector>

struct Number
{
    int row;
    int col;
    std::string num;
};

struct Gear
{
    int row;
    int col;
};

std::vector<Number> numbers;
std::vector<Gear> gears;

int to_number(std::string &n);
int solve();

int main()
{
    std::string line;
    std::fstream input_file("./input.txt");

    int i = 0, j;
    while (std::getline(input_file, line))
    {
        std::string num = "";
        for (j = 0; j < line.length(); j++)
        {
            if (line[j] == '*')
            {
                gears.push_back({i, j});
            }
            if (isdigit(line[j]))
            {
                num += line[j];
            }
            else if (num.length() > 0)
            {
                numbers.push_back({i, j - (int)num.length(), num});
                num = "";
            }
        }
        // if row ended with number
        if (num.length() > 0)
        {
            numbers.push_back({i, j - (int)num.length(), num});
        }
        i++;
    }

    std::cout << solve() << std::endl;

    return 0;
}

int to_number(std::string &n)
{
    int num = 0;
    for (int i = 0; i < n.length(); i++)
    {
        num *= 10;
        num += n[i] - '0';
    }
    return num;
}

int solve()
{
    int sum = 0;
    for (int i = 0; i < gears.size(); i++)
    {
        int product = 1;
        int num_of_nums = 0;
        for (int j = 0; j < numbers.size(); j++)
        {
            if ((gears[i].row == numbers[j].row && gears[i].col == numbers[j].col + numbers[j].num.length()) // left
                || (gears[i].row == numbers[j].row && gears[i].col == numbers[j].col - 1)                    // right
                ||
                ((gears[i].row == numbers[j].row + 1 || gears[i].row == numbers[j].row - 1) &&
                 ((gears[i].col - 1 >= numbers[j].col && gears[i].col - 1 < numbers[j].col + numbers[j].num.length()) ||
                  (gears[i].col >= numbers[j].col && gears[i].col < numbers[j].col + numbers[j].num.length()) ||
                  (gears[i].col + 1 >= numbers[j].col &&
                   gears[i].col + 1 < numbers[j].col + numbers[j].num.length())))) // top / bottom
            {
                product *= to_number(numbers[j].num);
                num_of_nums++;
            }
        }
        if (num_of_nums == 2)
        {
            sum += product;
        }
    }
    return sum;
}
