import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class StudentAnalyzerTest {

    @Test
    public void testCountExcellentStudents_MixedValidInvalid() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(2, analyzer.countExcellentStudents(Arrays.asList(9.0, 8.5, 7.0, 11.0, -1.0)));
    }

    @Test
    public void testCountExcellentStudents_EmptyList() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(0, analyzer.countExcellentStudents(Collections.emptyList()));
    }

    @Test
    public void testCountExcellentStudents_AllValid() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(3, analyzer.countExcellentStudents(Arrays.asList(8.0, 10.0, 8.1, 7.9)));
    }

    @Test
    public void testCountExcellentStudents_OnlyInvalids() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(0, analyzer.countExcellentStudents(Arrays.asList(-2.0, 10.5, null, -0.1, 11.0)));
    }

    @Test
    public void testCountExcellentStudents_NullsInside() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        List<Double> scores = Arrays.asList(8.0, null, 9.5, null, 7.0);
        assertEquals(2, analyzer.countExcellentStudents(scores));
    }

    @Test
    public void testCalculateValidAverage_MixedValidInvalid() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(8.17, analyzer.calculateValidAverage(Arrays.asList(9.0, 8.5, 7.0, 11.0, -1.0)), 0.01);
    }

    @Test
    public void testCalculateValidAverage_AllValid() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(7.275, analyzer.calculateValidAverage(Arrays.asList(8.0, 10.0, 8.1, 3.0)), 1e-9);
    }

    @Test
    public void testCalculateValidAverage_EmptyList() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(0.0, analyzer.calculateValidAverage(Collections.emptyList()), 0.0);
    }

    @Test
    public void testCalculateValidAverage_OnlyInvalids() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(0.0, analyzer.calculateValidAverage(Arrays.asList(null, -3.0, 10.5, 11.0)), 0.0);
    }

    @Test
    public void testCalculateValidAverage_BoundariesZeroAndTen() {
        StudentAnalyzer analyzer = new StudentAnalyzer();
        assertEquals(5.0, analyzer.calculateValidAverage(Arrays.asList(0.0, 10.0)), 0.0);
    }
}
