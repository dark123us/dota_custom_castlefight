(function (global) {

    const listeners = {}

    const subscribe = (event, callback) => {
        if (listeners[event] === undefined){
            listeners[event] = {id: 0, listeners: {}};
        }
        listeners[event].id ++;
        listeners[event][id] = callback;
        return listeners[event].id
    }

    const describe = (event, idListener) => {
        if (listeners[event] === undefined) return false;
        return delete listeners[event].listeners[idListener];
    }

    const NAME = "EVENT"
    const UNIT = {[NAME]: {subscribe, describe}}

    if (typeof define === "function" && define.amd) {
        define(UNIT[NAME]);
    } else if (typeof module !== "undefined" && module.exports) {
        module.exports = UNIT[NAME];
    } else {
        const prev = '_prev' + NAME
        UNIT[NAME][prev] = global[NAME];
        UNIT[NAME].noConflict = function () {
            global[NAME] = UNIT[NAME][prev];
            return UNIT[NAME];
        };
        global[NAME] = UNIT[NAME];
    }

})(this)

