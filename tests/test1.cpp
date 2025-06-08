#include "print.hpp"
#include <gtest/gtest.h>
#include <sstream>

TEST(PrintTest, BasicTest) {
    std::ostringstream oss;
    print("test", oss);
    EXPECT_EQ(oss.str(), "test\n");
}

TEST(PrintTest, DefaultStreamTest) {
    testing::internal::CaptureStdout();
    print("default");
    std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "default\n");
}
