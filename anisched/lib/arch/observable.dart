class ObservableData<T> {

    T? _data;

    List<Observer> _observerList = [];

    ObservableData({ T? data }) {
        _data = data;
    }

    T? get getData {
        return _data;
    }

    void setData(T data) {
        _data = data;

        Iterator iterator = _observerList.iterator;
        while (iterator.moveNext()) {
            iterator.current?.call(_data);
        }
    }

    void addObserver(Observer<T> observer) {
        _observerList.add(observer);
    }

    void removeAllObservers() {
        _observerList = [];
    }

}

class Observer<T> {

    final _onObservableDataChanged;

    Observer(this._onObservableDataChanged);

    void call(T data) {
        Future(() {
            _onObservableDataChanged(data);
        });
    }

}