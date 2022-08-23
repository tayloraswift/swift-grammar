
#if swift(>=5.7)
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
