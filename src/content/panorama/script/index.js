(function (global) {
    const log = global.logging.getLogger();

    log.debug("------------------");
    log.debug("    INIT INDEX");
    log.debug("==================");    // 

    const event = global.event.Event().init()
    const resdev = rnd.RD()
    resdev.init()

    const eventid = event.subscribe('hello', (params) => {
        log.debug(params)
    })
    
    log.debug({eventid})

    event.emit('hello', {a:2, b:3})




    const NAME = "MAIN"
    const UNIT = {[NAME]: {}}
    if (typeof define === "function" && define.amd) {
        define(UNIT[NAME]);
    } else if (typeof module !== "undefined" && module.exports) {
        module.exports = UNIT[NAME];
    } else {
        const prev = '_prev' + NAME
        UNIT[NAME][prev] = global[NAME];
        UNIT[NAME].noConflict = function () {
            global[NAME] = UNIT[NAME][prev]
            return UNIT[NAME];
        };
        global[NAME] = UNIT[NAME];
    }
})(this)
