/// A parsing rule that matches terminals against a constant ``Sequence``.
public
protocol LiteralRule<Terminal>:ParsingRule
    where Terminal:Equatable, Construction == Void 
{
    associatedtype Literal:Sequence<Terminal>
    
    static 
    var literal:Literal
    {
        get 
    }
}

extension LiteralRule
{
    @inlinable public static 
    func parse<Source>(_ input:inout ParsingInput<some ParsingDiagnostics<Source>>) throws
        where Source:Collection<Terminal>, Source.Index == Location
    {
        for expected:Terminal in Self.literal
        {
            switch input.next()
            {
            case expected?:
                continue
            
            case _?:
                throw Pattern.UnexpectedValueError.init()
            
            case nil:
                throw Pattern.UnexpectedEndOfInputError.init()
            }
        }
    }
}
