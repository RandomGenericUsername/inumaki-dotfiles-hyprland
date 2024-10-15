#include <date/date.h>
#include <iostream>
#include <chrono>

int main() {
    using namespace date;
    using namespace std::chrono;

    // Get current system time and print it
    auto now = floor<seconds>(system_clock::now());
    std::cout << "Current date and time: " << now << std::endl;

    return 0;
}
