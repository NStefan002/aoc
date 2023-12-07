#include <iostream>
#include <fstream>
#include <string>

std::pair<int, int> first_letter_digit_idx(std::string &s);
std::pair<int, int> last_letter_digit_idx(std::string &s);
std::pair<int, int> first_number_digit_idx(std::string &s);
std::pair<int, int> last_number_digit_idx(std::string &s);

std::string valid_digits[] = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};

int main()
{
    int sum = 0;
    std::string line;
    std::fstream input_file("./input.txt");
    while (std::getline(input_file, line))
    {
        std::pair<int, int> first_letter_idx = first_letter_digit_idx(line);
        std::pair<int, int> last_letter_idx = last_letter_digit_idx(line);
        std::pair<int, int> first_number_idx = first_number_digit_idx(line);
        std::pair<int, int> last_number_idx = last_number_digit_idx(line);

        int num = 0;

        if (first_letter_idx.first < first_number_idx.first)
        {
            num += 10 * first_letter_idx.second;
        }
        else
        {
            num += 10 * first_number_idx.second;
        }
        if (last_letter_idx.first > last_number_idx.first)
        {
            num += last_letter_idx.second;
        }
        else
        {
            num += last_number_idx.second;
        }

        sum += num;
    }

    std::cout << sum << std::endl;
}

std::pair<int, int> first_letter_digit_idx(std::string &s)
{
    std::pair<int, int> idx = {s.length(), -1};
    for (int i = 0; i < 9; i++)
    {
        int pos = s.find(valid_digits[i]);
        if (pos != std::string::npos)
        {
            if (pos < idx.first)
            {
                idx.first = pos;
                idx.second = i + 1;
            }
        }
    }
    return idx;
}
std::pair<int, int> last_letter_digit_idx(std::string &s)
{
    std::pair<int, int> idx = {-1, -1};
    for (int i = 0; i < 9; i++)
    {
        int pos = s.rfind(valid_digits[i]);
        if (pos != std::string::npos)
        {
            if (pos > idx.first)
            {
                idx.first = pos;
                idx.second = i + 1;
            }
        }
    }
    return idx;
}

std::pair<int, int> first_number_digit_idx(std::string &s)
{
    int idx = s.find_first_of("0123456789");
    if (idx != std::string::npos)
    {
        return {idx, s[idx] - '0'};
    }
    else
    {
        return {s.length(), -1};
    }
}
std::pair<int, int> last_number_digit_idx(std::string &s)
{
    int idx = s.find_last_of("0123456789");
    if (idx != std::string::npos)
    {
        return {idx, s[idx] - '0'};
    }
    else
    {
        return {-1, -1};
    }
}
