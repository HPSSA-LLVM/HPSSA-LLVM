#include<iostream>
using namespace std;

int main(){
    int m,n;
    cin>>m>>n;
    int result=0;
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            result++;
        }
    }
    while(true){
        for(int i=0;i<m;i++){
            for(int j=0;j<n;j++){
                result++;
            }
        }
        break;
    }


    // do random things with m and n
    m/=2;
    n/=2;
    for(int i=0;i<m;i++){
        if(i%2==0){
            for(int j=0;j<n;j++){
                result = result*2 + 1;
            }
        }
        else{
            for(int j=0;j<n;j++){
                result = result*2 + 2;
            }
        }
    }


    // suddenly, m and n are zero
    if(m==0){
        for(int i=0;i<n;i++){
            // do some weird stuff
            result = (result & 1) + (result >> 1);
        }
    }
    else{
        for(int i=0;i<m;i++){
            // do some weird stuff
            result = (result << 1) + (result & 1);
        }
    }


    return 0;
}