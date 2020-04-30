#include <stdio.h>
int PromptInt();
void PopulateArray(int *array, int size);
void PrintArray(int *array, int size);

int main()
{
    int size = PromptInt();
    
    int Fibonacci[size];
    PopulateArray(Fibonacci, size);
    
    PrintArray(Fibonacci, size);

    return 0;
}

int PromptInt()
{
    int num;
    printf("Enter a max Fibonacci number to calc: ");
    scanf("%d", &num);
    
    return num;
}

void PopulateArray(int *array, int size)
{
    array[0] = 0;
    array[1] = 1;
    
    for (int i = 2; i < size; i++) 
    {
        array[i] = array[i - 1] + array[i - 2];
    }
}

void PrintArray(int *array, int size) 
{
    for (int i = 0; i < size - 1; i++)
    {
        printf("%d, ", array[i]);
    }
    printf("%d", array[size - 1]);
}
