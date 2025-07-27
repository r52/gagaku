import type {
  DiscoverSection,
  DiscoverSectionItem,
  PagedResults,
  SelectorID,
  SelectorRegistry,
} from '@paperback/types'

type DiscoverSectionManager = Pick<
  typeof Application,
  | 'registerDiscoverSection'
  | 'unregisterDiscoverSection'
  | 'invalidateDiscoverSections'
  | 'registeredDiscoverSections'
>

export class MockDiscoverSectionManager implements DiscoverSectionManager {
  private selectorRegistry: SelectorRegistry
  private _registeredDiscoverSections: {
    section: DiscoverSection
    selector?: SelectorID<
      (
        section: DiscoverSection,
        metadata: unknown | undefined
      ) => Promise<PagedResults<DiscoverSectionItem>>
    >
  }[]

  constructor(selectorRegistry: SelectorRegistry) {
    this.selectorRegistry = selectorRegistry
    this._registeredDiscoverSections = []
  }

  registerDiscoverSection(
    section: DiscoverSection,
    selector?: SelectorID<
      (
        section: DiscoverSection,
        metadata: unknown | undefined
      ) => Promise<PagedResults<DiscoverSectionItem>>
    >
  ): void {
    this.unregisterDiscoverSection(section.id)
    this._registeredDiscoverSections.push({
      section,
      selector,
    })
  }

  unregisterDiscoverSection(sectionId: string): void {
    for (let i = 0; i < this._registeredDiscoverSections.length; i++) {
      const { section } = this._registeredDiscoverSections[i]!

      if (sectionId == section.id) {
        this._registeredDiscoverSections.splice(i, 1)
        return
      }
    }
  }

  invalidateDiscoverSections(): void {
    this._registeredDiscoverSections = []
  }

  registeredDiscoverSections(): DiscoverSection[] {
    return this._registeredDiscoverSections.map((x) => x.section)
  }
}
