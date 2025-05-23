type Fn = (...params: any) => any

function memoize(fn: Fn): Fn {
    const cache = new Map<string, any>();
    return function(...params) {
        const key = JSON.stringify(params);
        if (cache.has(key)) {
            return cache.get(key);
        }
        const result = fn(...params);
        cache.set(key, result);
        return result;
    }
}


/** 
 * let callCount = 0;
 * const memoizedFn = memoize(function (a, b) {
 *	 callCount += 1;
 *   return a + b;
 * })
 * memoizedFn(2, 3) // 5
 * memoizedFn(2, 3) // 5
 * console.log(callCount) // 1 
 */