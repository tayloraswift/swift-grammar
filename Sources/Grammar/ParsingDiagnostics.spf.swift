
#if swift(>=5.7)
public
protocol ParsingDiagnostics<Source> 
{
    associatedtype Source where Source:Collection 
    associatedtype Breadcrumb 
    
    init()
    
    mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
        -> Breadcrumb
    mutating 
    func pop()
    mutating 
    func reset(index:inout Source.Index, to:Breadcrumb, because:inout Error) 
}
#else 
public
protocol ParsingDiagnostics
{
    associatedtype Source where Source:Collection 
    associatedtype Breadcrumb 
    
    init()
    
    mutating 
    func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
        -> Breadcrumb
    mutating 
    func pop()
    mutating 
    func reset(index:inout Source.Index, to:Breadcrumb, because:inout Error) 
}
#endif 
extension Grammar 
{
    /// A performance-optimized diagnostic engine that maintains minimal internal 
    /// state, and emits no diagnostics.
    /// 
    /// Parsing with ``Grammar//NoDiagnostics`` is efficient, but does not provide 
    /// useful debugging information. The errors it emits may have little to do 
    /// with the intuitive reason why parsing failed.
    /// 
    /// For richer debugging information, use ``Grammar//DefaultDiagnostics`` instead.
    @frozen public 
    struct NoDiagnostics<Source>:ParsingDiagnostics where Source:Collection
    {
        @inlinable public 
        init() 
        {
        }
        // force inlining because these functions ignore most of their inputs, and 
        // don’t contain many instructions (if any)
        @inline(__always)
        @inlinable public 
        func push<Rule, Construction>(index:Source.Index, for _:Construction.Type, by _:Rule.Type) 
            -> Source.Index
        {
            index
        }
        @inline(__always)
        @inlinable public 
        func pop()
        {
        }
        @inline(__always)
        @inlinable public 
        func reset(index:inout Source.Index, to breadcrumb:Source.Index, because _:inout Error) 
        {
            index = breadcrumb 
        }
    }
    /// A debuggability-optimized diagnostic engine that maintains an internal 
    /// call stack, and emits rich diagnostics.
    /// 
    /// Parsing with ``Grammar//DefaultDiagnostics`` less efficient than parsing with 
    /// ``Grammar//NoDiagnostics``. However, the errors it emits may be more useful for 
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
        func reset(index:inout Source.Index, to _:Void, because error:inout Error)
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
}
