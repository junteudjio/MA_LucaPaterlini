import random
import bisect


# Implementing a random label generator
class PythonicRandomGen(object):
    # initialize the private arrays, check the probabilities to be floats retuning error if not.
    # returns errors as well if the len of the probabilities array is longer of the array of the names
    # Scale in case of sum of probabilities not equal to 1
    def __init__(self, names, val):
        if not self._check_float_list(val):
            raise FloatingPointError
        if len(val) > len(names):
            raise LookupError
        k = 1/sum(val)
        # initialize the sumparray
        s = 0
        self._sumparray = []
        for x in val:
            s += x * k
            self._sumparray.append(s)
        self._random_nums = names
        self._probabilities = val

    # return the next random after checking if its ready to
    def next_num(self):
        rfloat = random.random()
        return self._random_nums[bisect.bisect_left(self._sumparray, rfloat)]

    # checks the input is a float of integers
    def _check_float_list(self, lst):
        return type(lst) is list and all(isinstance(x, float) for x in lst)
