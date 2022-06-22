# Source-Schema Co-Evolution: Code, Data and Results (2022)

The set of 195 source systems was further studied for the co-evolution of source code and schema. For more explanations and findings, please refer to the [Schema Biographies](http://www.cs.uoi.gr/~pvassil/projects/schemaBiographies/index.html) site.

The current collection of these data has been uploaded by Panos Vassiliadis, in June 2022.

The folders contain:
- The data, i.e., for each project: (a) info of schema and code changes per commit, (b)  monthly summaries of the above, (c) percentages of progress and charts for source-schema co-evolution
- The source code to produce these results
- A summary of some case studies
- The results, including Excel files with co-evo statistics and profiles for all the studied projects, as well as summary statistics 

## How to cite
> Panos Vassiliadis, Fation Shehaj, George Kalampokis, Apostolos V. Zarras.  Joint Source and Schema Evolution: Insights from a Study of 195 FOSS Projects. 26th International Conference on Extending Database Technology (EDBT), 28th March - 31st March, 2023, Ioannina, Greece.

## Tools

The basic toolset for producing these results is in the folder `02_src`. 

Our tool set also includes:

- [Hecate](https://github.com/DAINTINESS-Group/Hecate) for extracting the history of a schema
- [Heraclitus Fire](https://github.com/pvassil/HeraclitusFire) for extracting statistics for such a history
