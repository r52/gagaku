import type { SearchFilter } from '@paperback/types'

type SearchFilterManager = Pick<
  typeof Application,
  | 'registerSearchFilter'
  | 'unregisterSearchFilter'
  | 'invalidateSearchFilters'
  | 'registeredSearchFilters'
>

export class MockSearchFilterManager implements SearchFilterManager {
  private _registeredSearchFilters: SearchFilter[]

  constructor() {
    this._registeredSearchFilters = []
  }

  registerSearchFilter(filter: SearchFilter): void {
    this.unregisterSearchFilter(filter.id)
    this._registeredSearchFilters.push(filter)
  }

  unregisterSearchFilter(filterId: string): void {
    for (let i = 0; i < this._registeredSearchFilters.length; i++) {
      const filter = this._registeredSearchFilters[i]!

      if (filterId == filter.id) {
        this._registeredSearchFilters.splice(i, 1)
        return
      }
    }
  }

  invalidateSearchFilters(): void {
    this._registeredSearchFilters = []
  }

  registeredSearchFilters(): SearchFilter[] {
    return this._registeredSearchFilters
  }
}
