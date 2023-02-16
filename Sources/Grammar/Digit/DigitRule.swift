#if swift(>=5.7)
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
#else 
/// A parsing rule that is applied to a single terminal at a time, and produces 
/// some ``BinaryInteger`` as its output.
public
protocol DigitRule:TerminalRule where Construction:BinaryInteger
{    
    static 
    var radix:Construction 
    {
        get 
    }
}
#endif 
