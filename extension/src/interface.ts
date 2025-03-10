import { Source } from "@paperback/types";
import { RDUISection } from "./DUI";

export interface WebViewInterface {
    callHandler(handlerName: String, ...args: any[]): any;
}

declare global {
    var gagaku: WebViewInterface | undefined;
    function processSourceMenu(source: Source): Promise<RDUISection>;
    function callBinding(id: string, ...args: any[]): Promise<any>
}