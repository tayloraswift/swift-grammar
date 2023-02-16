/// A parsing rule that is applied to a single terminal at a time, and produces 
/// some ``BinaryInteger`` as its output.
public
protocol DigitRule<Terminal, Construction>:TerminalRule where Construction:BinaryInteger
{    
    static 
    var radix:Construction 
    {
        get 
    }
}
