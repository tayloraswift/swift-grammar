/// A debuggability-optimized diagnostic engine that maintains an internal 
/// call stack, and emits rich diagnostics.
/// 
/// Parsing with ``DefaultDiagnostics`` less efficient than parsing with 
/// ``NoDiagnostics``. However, the errors it emits may be more useful for 
/// understanding the intuitive reason why parsing failed.
@frozen public 
struct DefaultDiagnostics<Source>:ParsingDiagnostics where Source:Collection
{
    public 
    var stack:[ParsingError<Source.Index>.Frame], 
        frontier:ParsingError<Source.Index>?
    @inlinable public 
    init() 
    {
        self.stack      = []
        self.frontier   = nil 
    }
    @inlinable public mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type)
    {
        self.stack.append(.init(index: index, rule: Rule.self, construction: Construction.self))
    }
    @inlinable public mutating 
    func pop()
    {
        self.stack.removeLast()
    }
    @inlinable public mutating 
    func reset(index:inout Source.Index, to _:Void, because error:inout any Error)
    {
        defer 
        {
            index = self.stack.removeLast().index 
        }
        if  error is ParsingError<Source.Index> 
        {
            return 
        }
        if let diagnostic:ParsingError<Source.Index> = self.frontier, index < diagnostic.index
        {
            // we did not make it as far as the previous most-successful parse 
            error           = diagnostic 
        }
        else 
        {
            let diagnostic:ParsingError<Source.Index> = .init(at: index, 
                because: error, trace: self.stack) 
            self.frontier   = diagnostic 
            error           = diagnostic
        }
    }
}