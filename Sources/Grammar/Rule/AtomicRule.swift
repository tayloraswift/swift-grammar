/// A parsing rule that matches terminals against a constant value.
public
protocol AtomicRule<Terminal>:TerminalRule
    where Terminal:Equatable, Construction == Void 
{
    static 
    var terminal:Terminal { get }
}

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
    func parse<Source>(_ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws
        where Source:Collection<Terminal>, Source.Index == Location
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
