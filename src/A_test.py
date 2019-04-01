import unittest
import random
import A
from collections import defaultdict


class TestStringMethods(unittest.TestCase):

    def test_WrongInput(self):
        random_nums = ["hello"]
        probabilities = [0.01, 0.3, 0.58, 0.1, 0.1]
        try:
            A.PythonicRandomGen(random_nums, probabilities)
            self.fail(msg="Error Exected on len(random_nums) > len(probabilities)")
        except (LookupError, FloatingPointError):
            pass

    def test_RandomSample(self):
        #config
        random.seed(1)
        obj = A.PythonicRandomGen(['hello', 'luca'], [1.0, 2.0])
        N = 100
        expected = defaultdict(int)
        expected['hello'] = 29
        expected['luca'] = 71
        result = defaultdict(int)
        for _ in range(N):
            result[obj.next_num()] += 1
        self.assertDictEqual(expected,result)


if __name__ == '__main__':
    unittest.main()
