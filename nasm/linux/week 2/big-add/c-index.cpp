// C++ implementation of above approach
#include <bits/stdc++.h>
using namespace std;
 
// Function to count the number of
// carry operations
int count_carry(string a, string b)
{
    // Initialize the value of carry to 0
    int carry = 0;
 
    // Counts the number of carry operations
    int count = 0;
 
    // Initialize len_a and len_b with the sizes of strings
    int len_a = a.length(), len_b = b.length();
 
    while (len_a != 0 || len_b != 0) {
 
        // Assigning the ascii value of the character
        int x = 0, y = 0; ; // ascii to int // atoi
        if (len_a > 0) {
            x = a[len_a - 1] - '0'; //  atoi single byte
            len_a--; 
        }
        if (len_b > 0) {
            y = b[len_b - 1] - '0';
            len_b--;
        }
 
        // Add both numbers/digits
        int sum = x + y + carry;
 
        // If sum > 0, increment count
        // and set carry to 1
        if (sum >= 10) {
            carry = 1;
            count++;
        }
 
        // Else, set carry to 0
        else
            carry = 0;
    }
 
    return count;
}
 
// Driver code
int main()
{
 
    string a = "9555", b = "555";
 
    int count = count_carry(a, b);
    if (count == 0)
        cout << "0\n";
    else if (count == 1)
        cout << "1\n";
    else
        cout << count << "\n";
 
    return 0;
}