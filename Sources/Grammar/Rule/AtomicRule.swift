#if swift(>=5.7)
/// A parsing rule that matches terminals against a constant value.
public
protocol AtomicRule<Terminal>:TerminalRule
    where Terminal:Equatable, Construction == Void 
{
    static 
    var terminal:Terminal { get }
}
#else 
/// A parsing rule that matches terminals against a constant value.
public
protocol AtomicRule:TerminalRule
    where Terminal:Equatable, Construction == Void 
{
    static 
    var terminal:Terminal { get }
}
#endif 
extension AtomicRule
{
    @inlinable public static 
    func parse(terminal:Terminal) -> Void?
    {
        Self.terminal == terminal ? () : nil
    }
}
extension AtomicRule
{
    @inlinable public static 
    func parse<Diagnostics>(_ input:inout ParsingInput<Diagnostics>) throws
        where   Diagnostics:ParsingDiagnostics, 
                Diagnostics.Source.Index == Location,
                Diagnostics.Source.Element == Terminal
    {
        switch input.next()
        {
        case Self.terminal?:
            break
        
        case _?:
            throw Pattern.UnexpectedValueError.init()
        
        case nil:
            throw Pattern.UnexpectedEndOfInputError.init()
        }
    }
}
