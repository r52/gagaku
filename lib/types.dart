class CRef {
  Object ref;

  CRef(this.ref);

  T get<T>() {
    return ref as T;
  }

  void replace(Object other) {
    ref = other;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CRef &&
            other.ref.runtimeType == ref.runtimeType &&
            identical(other.ref, ref));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ref);
}
