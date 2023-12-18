#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
#include <algorithm>

enum HandType
{
    HIGH_CARD,
    ONE_PAIR,
    TWO_PAIR,
    THREE_OF_KIND,
    FULL_HOUSE,
    FOUR_OF_KIND,
    FIVE_OF_KIND,
};

std::map<char, int> card_value = {
    {'2', 2}, {'3', 3},  {'4', 4}, {'5', 5},  {'6', 6},  {'7', 7},  {'8', 8},
    {'9', 9}, {'T', 10}, {'J', 1}, {'Q', 12}, {'K', 13}, {'A', 14},
};

class Hand
{
  public:
    std::string cards;
    int bid;
    HandType ht;

    HandType determine_hand_type()
    {
        std::vector<char> c;
        for (int i = 0; i < cards.length(); i++)
        {
            c.push_back(cards[i]);
        }
        std::sort(begin(c), end(c), [](char c1, char c2) {
            if (c1 == 'J')
            {
                return false;
            }
            if (c2 == 'J')
            {
                return true;
            }
            return c1 < c2;
        });

        HandType t = HIGH_CARD;
        int repetitions = 1;
        int num_of_Js = 0;
        for (int i = 1; i < c.size(); i++)
        {
            if (c[i] == 'J')
            {
                num_of_Js = c.size() - i;
                break;
            }
            if (c[i] == c[i - 1])
            {
                repetitions++;
                switch (t)
                {
                case HIGH_CARD:
                    t = ONE_PAIR;
                    break;
                case ONE_PAIR:
                    if (repetitions == 2)
                    {
                        t = TWO_PAIR;
                    }
                    else
                    {
                        t = THREE_OF_KIND;
                    }
                    break;
                case TWO_PAIR:
                    t = FULL_HOUSE;
                    break;
                case THREE_OF_KIND:
                    if (repetitions == 2)
                    {
                        t = FULL_HOUSE;
                    }
                    else
                    {
                        t = FOUR_OF_KIND;
                    }
                    break;
                case FULL_HOUSE:
                    break;
                case FOUR_OF_KIND:
                    t = FIVE_OF_KIND;
                case FIVE_OF_KIND:
                    break;
                }
            }
            else
            {
                repetitions = 1;
            }
        }
        switch (t)
        {
        case HIGH_CARD:
            if (num_of_Js == 1)
                t = ONE_PAIR;
            else if (num_of_Js == 2)
                t = THREE_OF_KIND;
            else if (num_of_Js == 3)
                t = FOUR_OF_KIND;
            else if (num_of_Js > 3)
                t = FIVE_OF_KIND;
            break;
        case ONE_PAIR:
            if (num_of_Js == 1)
                t = THREE_OF_KIND;
            else if (num_of_Js == 2)
                t = FOUR_OF_KIND;
            else if (num_of_Js == 3)
                t = FIVE_OF_KIND;
            break;
        case TWO_PAIR:
            if (num_of_Js == 1)
                t = FULL_HOUSE;
            break;
        case THREE_OF_KIND:
            if (num_of_Js == 1)
                t = FOUR_OF_KIND;
            else if (num_of_Js == 2)
                t = FIVE_OF_KIND;
            break;
        case FULL_HOUSE:
            break;
        case FOUR_OF_KIND:
            if (num_of_Js == 1)
                t = FIVE_OF_KIND;
            break;
        case FIVE_OF_KIND:
            break;
        }
        return t;
    }

    Hand(std::string c, int b)
    {
        cards = c;
        bid = b;
        ht = determine_hand_type();
    }
    bool operator<(const Hand &h)
    {
        if (ht < h.ht)
        {
            return true;
        }
        if (ht > h.ht)
        {
            return false;
        }
        for (int i = 0; i < cards.length(); i++)
        {
            if (card_value[cards[i]] < card_value[h.cards[i]])
            {
                return true;
            }
            if (card_value[cards[i]] > card_value[h.cards[i]])
            {
                return false;
            }
        }
        return false;
    }
};

int main()
{
    std::vector<Hand> hands;
    std::fstream input_file("input.txt");

    std::string cards;
    int bid;
    while (input_file >> cards >> bid)
    {
        hands.push_back({cards, bid});
    }

    std::sort(begin(hands), end(hands));
    int sum = 0;
    for (int i = 0; i < hands.size(); i++)
    {
        sum += (i + 1) * hands[i].bid;
    }

    std::cout << sum << std::endl;

    return 0;
}
