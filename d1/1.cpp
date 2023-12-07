#include <iostream>
#include <fstream>
#include <string>
#include <cctype>

int combine_digits(std::string &s);

int main()
{
    int sum = 0;
    std::ifstream input_file("./input.txt");
    std::string line;
    while (std::getline(input_file, line))
    {
        sum += combine_digits(line);
    }

    std::cout << sum << std::endl;

    return 0;
}

int combine_digits(std::string &s)
{
    int d1 = -1, d2 = -1;
    int i = 0, j = s.length() - 1;
    while (d1 < 0 || d2 < 0)
    {
        if (isdigit(s[i]) && d1 < 0)
        {
            d1 = s[i] - '0';
        }
        if (isdigit(s[j]) && d2 < 0)
        {
            d2 = s[j] - '0';
        }
        i++;
        j--;
    }

    return 10 * d1 + d2;
}
