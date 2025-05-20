import { PaperbackPolyfills } from "./PBPolyfills"
import './RawData'
import './RequestManager'
import './SourceStateManager'
import './DUI'
import * as cheerio from 'cheerio'

// @ts-ignore
globalThis.App = new Proxy(PaperbackPolyfills, {
	get(target, p) {
		// @ts-ignore
		if(target[p]) {
			// @ts-ignore
			return target[p]
		}

		if(typeof p === 'string' && p.startsWith('create')) {
			return (anyProps: any) => anyProps
		}

		return undefined
	}
})

// @ts-ignore
globalThis.cheerio = cheerio;
