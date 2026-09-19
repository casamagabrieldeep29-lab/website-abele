import { Award, Flame, ListChecks, Target, type LucideIcon } from "lucide-react";

// Fixed achievement definitions — the actual thresholds live in
// check_and_award_achievements() in schema.sql; this file only needs to
// match those codes for display purposes (label/description/icon).
export const ACHIEVEMENTS: Record<string, { label: string; description: string; icon: LucideIcon }> = {
  FIRST_100: { label: "First 100", description: "Answered 100 questions", icon: Award },
  FIVE_HUNDRED: { label: "500 Questions", description: "Answered 500 questions", icon: Award },
  ONE_THOUSAND: { label: "1,000 Questions", description: "Answered 1,000 questions", icon: Award },
  ACCURACY_90: { label: "90% Accuracy", description: "90%+ overall accuracy (50+ questions)", icon: Target },
  MOCK_COMPLETE: { label: "First Mock Exam", description: "Completed a mock exam", icon: ListChecks },
  STREAK_7: { label: "7-Day Streak", description: "Studied 7 days in a row", icon: Flame },
  STREAK_14: { label: "14-Day Streak", description: "Studied 14 days in a row", icon: Flame },
};
