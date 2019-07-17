import std.range, std.stdio;
import std.conv;
import std.uni : toLower;
import std.algorithm.sorting : sort;

void main()
{
    string[][string] table;
    string[] empty;

    auto file = File("./wordlist.txt");
    auto range = file.byLine();
    foreach (line; range)
    {
        auto word = toLower(line);
        const string sorted = to!string(word.array.sort);
        table.require(sorted, empty);
        table[sorted] ~= sorted;
    }
    int cnt;
    foreach (v; table.byValue())
    {
        if (v.length > 1)
        {
            writeln(v);
            cnt++;
        }
    }
    writeln(cnt);
}
