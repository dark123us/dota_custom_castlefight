(function(global){
    'use strict';
    const log = global.logging.getLogger()
    const event = global.event.Event()
    const tooltip = global.tooltip.ToolTip()

    const RD = () => {
        const data = () => {}
        data.init = () => {
            log.debug("init rnd")
            const eventid = event.subscribe('hello', (params) => {
                log.debug(params)
            })
            log.debug({eventid})

            const values = {
                windrunner_shackleshot: {
                    name: 'HEAVY TANK FACTORY',
                    gold: 340,
                    tree: 150,
                    place: 2,
                    attack: [1400, '36-42', 150],
                    defence: [2, '25%'],
                    mobility: [305, '25%'],
                    info: 'Но непосредственные участники технического прогресса лишь добавляют фракционных разногласий и указаны как.',
                    vipheader:'Castle Fight Plus',
                    vip: 'В основном юнит берётся для того чтобы подавить аир противника',
                    activeheader: 'Активная: Ракетная турель',
                    active: 'Каждые 1.5с запускает ракету в случайного воздушного юнита в радиусе. Ракета наносит 175 урона.',
                    actives: [175, 1200, 1.5],
                    passiveheader: 'Пассивная: Тяжелая броня',
                    passive: 'Юнит получает +10 ед. брони и гарантировано блокирует 40 урона от любого источника.',
                    note: 'Не может атаковать воздушные цели',
                    lore: 'Описание лора и прочих ништяков.',
                },
                windrunner_powershot: {
                    name: 'LIGHT TANK FACTORY',
                    gold: 440,
                    tree: 110,
                    place: 1,
                    attack: [1100, '21-23', 120],
                    defence: [2, '25%'],
                    mobility: [305, '25%'],
                    info: 'Но непосредственные участники технического прогресса лишь добавляют фракционных разногласий и указаны как.',
                    vipheader:'Castle Fight Plus',
                    vip: 'В основном юнит берётся для того чтобы подавить аир противника',
                    activeheader: 'Активная: Ракетная турель',
                    active: 'Каждые 1.5с запускает ракету в случайного воздушного юнита в радиусе. Ракета наносит 175 урона.',
                    actives: [175, 1200, 1.5],
                    passiveheader: 'Пассивная: Тяжелая броня',
                    passive: 'Юнит получает +10 ед. брони и гарантировано блокирует 40 урона от любого источника.',
                    note: 'Не может атаковать воздушные цели',
                    lore: 'Описание лора и прочих ништяков.',
                },
                windrunner_windrun: {
                    name: 'HEAVY TANK FACTORY',
                    gold: 340,
                    tree: 150,
                    place: 1,
                    attack: [1400, '36-42', 150],
                    defence: [2, '25%'],
                    mobility: [305, '25%'],
                    info: 'Но непосредственные участники технического прогресса лишь добавляют фракционных разногласий и указаны как.',
                    vipheader:'Castle Fight Plus',
                    vip: 'В основном юнит берётся для того чтобы подавить аир противника',
                    activeheader: 'Активная: Ракетная турель',
                    active: 'Каждые 1.5с запускает ракету в случайного воздушного юнита в радиусе. Ракета наносит 175 урона.',
                    actives: [175, 1200, 1.5],
                    passiveheader: 'Пассивная: Тяжелая броня',
                    passive: 'Юнит получает +10 ед. брони и гарантировано блокирует 40 урона от любого источника.',
                    note: 'Не может атаковать воздушные цели',
                    lore: 'Описание лора и прочих ништяков.',
                },
                windrunner_focusfire: {
                    name: 'HEAVY TANK FACTORY',
                    gold: 340,
                    tree: 150,
                    place: 1,
                    attack: [1400, '36-42', 150],
                    defence: [2, '25%'],
                    mobility: [305, '25%'],
                    info: 'Но непосредственные участники технического прогресса лишь добавляют фракционных разногласий и указаны как.',
                    vipheader:'Castle Fight Plus',
                    vip: 'В основном юнит берётся для того чтобы подавить аир противника',
                    activeheader: 'Активная: Ракетная турель',
                    active: 'Каждые 1.5с запускает ракету в случайного воздушного юнита в радиусе. Ракета наносит 175 урона.',
                    actives: [175, 1200, 1.5],
                    passiveheader: 'Пассивная: Тяжелая броня',
                    passive: 'Юнит получает +10 ед. брони и гарантировано блокирует 40 урона от любого источника.',
                    note: 'Не может атаковать воздушные цели',
                    lore: 'Описание лора и прочих ништяков.',
                }
            }
            const labels = {
                lblAttack: 'Attack',
                lblDefence: 'Defence',
                lblMobility: 'Mobility',
            }

            
            tooltip.init({
                pathXml: 'file://{resources}/layout/custom_game/tooltip.xml',
                labels,
                values,
                })

        }
        return data;
    };

    log.error({a:12})
    console.error('a = 12')
    log.debug({res:global.resources})

    const NAME = "rnd"
    const UNIT = {[NAME]: {RD}}
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
})(this);
