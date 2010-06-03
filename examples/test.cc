#include <iostream>

using namespace std;

const char * compilation_date = "$START$ `date`.strip $STOP$";

int main(int argc, char * argv[]) {
     cout << "file compiled on " << compilation_date << endl;
     return 0;
}


