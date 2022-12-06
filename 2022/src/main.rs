use std::collections::HashMap;

fn main() {
    day1();
    day2();
    day3();
    day4();
}

fn day1() {
    println!("Day 1");
    let data = include_str!("../data/day1.txt");

    let rows = data.lines();
    let mut first = 0;
    let mut second = 0;
    let mut third = 0;
    let mut sum = 0;
    for row in rows {
        if row == "" {
            if sum > first {
                third = second;
                second = first;
                first = sum;
            } else if sum > second {
                third = second;
                second = sum;
            } else if sum > third {
                third = sum;
            }
            sum = 0;
        } else {
            sum += row.parse::<i32>().expect("One row in data is not an int");
        }
    }

    println!("Part 1: {}", first);
    println!("Part 2: {}", first + second + third);
}

fn day2() {
    println!("Day 2");
    let data = include_str!("../data/day2.txt");

    // Part 1
    let score_map = HashMap::from([
        ("A X", 4),
        ("A Y", 8),
        ("A Z", 3),
        ("B X", 1),
        ("B Y", 5),
        ("B Z", 9),
        ("C X", 7),
        ("C Y", 2),
        ("C Z", 6),
    ]);

    let rows = data.lines().filter(|row| row != &"");
    let mut total = 0;
    for row in rows {
        total += score_map[row];
    }

    println!("Part 1: {}", total);

    // Part 2
    let play_map = HashMap::from([
        ("A X", "A Z"),
        ("A Y", "A X"),
        ("A Z", "A Y"),
        ("B X", "B X"),
        ("B Y", "B Y"),
        ("B Z", "B Z"),
        ("C X", "C Y"),
        ("C Y", "C Z"),
        ("C Z", "C X"),
    ]);

    let rows = data.lines().filter(|row| row != &"");
    let mut total = 0;
    for row in rows {
        total += score_map[play_map[row]];
    }

    println!("Part 2: {}", total);
}

fn day3() {
    println!("Day 3");
    let data = include_str!("../data/day3.txt");
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

    let rows = data.lines().filter(|row| row != &"");
    let mut total: usize = 0;
    for row in rows {
        let (first_half, second_half) = row.split_at(row.len() / 2);
        for char in first_half.chars() {
            if second_half.contains(char) {
                total += letters.find(char).unwrap_or(0) + 1;
                break;
            }
        }
    }
    println!("Part 1: {}", total);

    let rows = data.lines().filter(|row| row != &"").collect::<Vec<&str>>();
    let chunks = rows.chunks(3);
    let mut total: usize = 0;
    for chunk in chunks {
        for char in chunk[0].chars() {
            if chunk[1].contains(char) && chunk[2].contains(char) {
                total += letters.find(char).unwrap_or(0) + 1;
                break;
            }
        }
    }
    println!("Part 2: {}", total);
}

fn day4() {
    println!("Day 4");
    let data = include_str!("../data/day4.txt");

    let rows = data.lines().filter(|row| row != &"");
    let mut fully_contained_count = 0;
    let mut partially_contained_count = 0;
    for row in rows {
        let jobs = row
            .split([',', '-'])
            .flat_map(|i| i.parse())
            .collect::<Vec<i32>>();
        let a = jobs[0];
        let b = jobs[1];
        let x = jobs[2];
        let y = jobs[3];

        if (a <= x && x <= b && a <= y && y <= b) || (x <= a && a <= y && x <= b && b <= y) {
            fully_contained_count += 1;
        }
        if (a <= x && x <= b) || (a <= y && y <= b) || (x <= a && a <= y) || (x <= b && b <= y) {
            partially_contained_count += 1;
        }
    }
    println!("Part 1: {}", fully_contained_count);
    println!("Part 2: {}", partially_contained_count);
}

fn day5() {
    println!("Day 5");
    let data = include_str!("../data/day5.txt");
}
