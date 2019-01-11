import time
class CFormat(object):
    """转换bytes和time.striptime对象"""
    def to_json(dictobj):
        if isinstance(dictobj,bytes):
            return {"__class__":"bytes","__value__":list(dictobj)}
        if isinstance(dictobj,time.struct_time):
            return {"__class__":"struct_time","__value__":time.asctime(dictobj)}
        return dictobj

    def from_json(dictobj):
        if "__class__" in dictobj:
            if dictobj["__class__"]=="bytes":
                return bytes(dictobj["__value__"])
            if dictobj["__class__"]=="struct_time":
                return time.strptime(dictobj["__value__"])
        return dictobj


