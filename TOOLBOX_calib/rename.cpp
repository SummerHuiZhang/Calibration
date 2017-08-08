#include <opencv2/opencv.hpp>
#include <fstream>
#include <string>
#include <sstream>
#include <iomanip>
int main(int argc, char** argv)
{
    std::string list_name = argv[1];   
    std::ifstream list;
    list.open(list_name.c_str());
    std::string name;
    int count = 0;
    while(list >> name)
    {
        cv::Mat image = cv::imread(name);
        std::string new_name_pre = "result/Image_";
        std::ostringstream ss;
        ss << std::setw(6) << std::setfill( '0' ) << count;
        std::string new_name= ss.str();
        cv::imwrite(new_name_pre+ new_name+".png",image);
        count++;

    }
}
