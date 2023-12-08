#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cctype>

int main()
{
    std::vector<std::string> lines;
    std::string line;
    std::string new_line;
    std::string empty_line;
    std::fstream input_file("./input.txt");
    while (std::getline(input_file, line))
    {
        new_line = "." + line + ".";
        if (lines.empty())
        {
            for (int i = 0; i < new_line.length(); i++)
            {
                empty_line.push_back('.');
            }
            lines.push_back(empty_line);
        }
        lines.push_back(new_line);
    }
    lines.push_back(empty_line);
    int sum = 0;
    for (int i = 0; i < lines.size(); i++)
    {
        int num = 0;
        bool valid = false;
        for (int j = 0; j < lines[i].length(); j++)
        {
            if (std::isdigit(lines[i][j]))
            {
                num *= 10;
                num += lines[i][j] - '0';
                if (lines[i - 1][j] != '.' || lines[i + 1][j] != '.' || lines[i - 1][j - 1] != '.' ||
                    lines[i - 1][j + 1] != '.' || lines[i + 1][j - 1] != '.' || lines[i + 1][j + 1] != '.')
                {
                    valid = true;
                }
                if ((lines[i][j + 1] != '.' && !std::isdigit(lines[i][j + 1])) ||
                    (lines[i][j - 1] != '.' && !std::isdigit(lines[i][j - 1])))
                {
                    valid = true;
                }
            }
            else if (j == lines[i].length() - 1)
            {
                if (valid)
                {
                    sum += num;
                }
            }
            else
            {
                if (valid)
                {
                    sum += num;
                }
                num = 0;
                valid = false;
            }
        }
    }
    std::cout << sum << std::endl;

    return 0;
}
