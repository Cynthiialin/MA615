

ui <- dashboardPage(
  dashboardHeader(title = "World Values Survey"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction ", tabName = "about", icon = icon("info")),
      menuItem("Appendix&Reference", tabName = "explain", icon = icon("file"))
    )
  ),
  
  
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "about",
        fluidRow(
          box(
            title = "About the Project",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("This report gives an overview of the quantitative data analysis of 244 survey questions that were conducted
                  by a network of social scientists at Michigan University in 2011. The purpose of this report is to know how United States 
                  whole society affects and changes participants’ attitude, values and belief on economy, education, work, family, politics, 
                  culture, national identity, environment, gender equality, religion, security, impact of globalization, wiliness to join different 
                  organizations, tendency to immigrate, characteristics of democracy, morality, happiness toward life, social network, science/technology 
                  development.")
            )
            ),
        fluidRow(
          box(
            title = "Data Source",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("World Values Survey website contains questionnaire, codebook, statistical data files on 
                  the Data&Documentation section in almost 100 countries. I access the 2011 United States raw data on 
                  Wave 6 and obtain the data in Csv file. The survey was conducted from 06.09.2011-07.05.2011. There are 
                  in total 70.86% cooperation rate with 2232 cases
                  completed out of 3150 cases.")
            )
            ),
        fluidRow(
          box(
            title = "Data",
            solidHeader = TRUE,
            width = 12,
            status = "primary",
            collapsible = TRUE,
            column(12,
                   
                   tableOutput("head")
            )
          )
        )
            ),
      tabItem(
        tabName = "data",
        fluidRow(
          box(
            title = "Methodology",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("Small protest of the World Values Survey has verified the data accuracy and time of the survey, dataset itself has no mistakes but
                  some redundant questions with similar information.
                  To answer this question, I analyzed what participants have answered on World Value Survey questions, used exploratory data analysis and exploratory factor 
                  analysis to explores people’s values and beliefs in the United States.")
            )),
        
        fluidRow(
          box(
            title = "Exploratory Data Analysis (EDA)",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("Several exploratory data analysis (EDA) plots for people’s point of view on education, work, religion, 
                  gender value is in discussion section.") 
            )
          ),
        fluidRow(
          box(
            title = "Exploratory Factor Analysis (EFA)",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("Exploratory Factor Analysis (EFA) is used to. measure, monitors and analyzes World Value Survey Dataset in the 
                  following major components: Tolerance of ethnic minorities and foreigners, attitudes toward economy, education, work, 
                  family, politics, culture, national identity, environment, gender equality, religion, security, impact of globalization, 
                  wiliness to join different organizations, tendency to immigrate, characteristics of democracy, morality, happiness toward 
                  life, social network, science/technology development.") 
            )
            )
            ), 
      tabItem(
        tabName = "rawdata",
        fluidRow(
          box(
            title = "Discussion",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            print("After doing data cleaning including removing NA values and deleting columns that have questions have not been asked, 
                  the whole dataset contains 244 variables. Then, Exploratory Factor Analysis (EFA) has been used so that 244 variables were condensed into 
                  only twenty major factors that are valuable to analyze.   ")
            )
            )
        
        
        ,
        fluidRow(
          box(
            title = "Education",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            column(12,
                   plotOutput("diag"),
                   print("Number one stands for no formal education and number ten stands for university-level education, 
                         with degree. As the unit number increases, highest education level increases. 
                         Together, two gender plots both show the general pattern of large amount of complete secondary:
                         university-preparatory type and some university-level education, without degree. ")
                   )
                   )
          
                   )
        
          ),
      tabItem(
        tabName = "plot_rawdata",
        fluidRow(
          box(
            title = "Exploratory Factor Analysis",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = FALSE,
            print("Exploratory Factor Analysis (EFA) is used in 2011 US World Value Survey data analysis report. Due to large number of variables 
                  with multicollinearity relationship, it is essential to reduce data to a smaller set of summary variables. EFA helps explore the underlying
                  structure and similarity among 244 variables. From Parallel Analysis Screen Plot in Table 6.1, optimized factor number is around twenty which is the 
                  intersection between FA Actual Data and FA Resampled Data. After arrived at a probable number of factors, it is time to perform factor analysis at number twenty. 
                  Output showing factors and loadings are in Table 6.2. Note that there are MR1-MR20 numbers for each column variable. By looking at the largest result 
                  in each row, 244 variables are grouped into twenty categories. Then, validation of factor analysis is used in current stage. The root mean square of residuals 
                  (RMSR) is 0.02 which is pretty closer to 0. RMSEA (root mean square error of approximation) index is 0.042. As it is below 0.05, it is a good model fit based 
                  on RMSEA. Only Tucker-Lewis Index (TLI) is slightly a little smaller than the normal number but the other two conditions are satisfied. New twenty factors are 
                  formed depending on the variable loading. On Table 6.4 and Table 6.5 are named- factors after establishing the adequacy of the factors. 
                  
                  ")
            )
            ),
        fluidRow(
          box(
            title = "Factor Analysis",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = TRUE,
            column(12,
                   plotOutput("factor")
                   
            )
          )
        )
            ),
      tabItem(
        tabName = "Survey",
        fluidRow(
          box(
            title = "Result",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = FALSE,
            print("Individual Values certainly differ among gender, education background, income and ethnicity.
                  One of reasons that U.S citizens answered the questionnaires in certain ways is because of the existence of emancipative values. Emancipative values in one of the major cultural       components of human empowerment in the United States. Emancipative values help increase people’s capabilities, aspirations and entitlements to exercise freedom. Generally, there are four categories of defining personal value and belief, including traditional values, secular-rational values, survival values and self-expression values. Firstly, traditional values have preferences on religion, parent-child ties, deference to traditional family values and rejection to suicide, abortion and divorce. US society places emphasis on traditional values which have a high level of national pride. The opposite preferences to traditional values are called secular-rational values. As existential security in US increases, the society cultivates more on traditional value.
                  Additionally, there are two opposite values which belong to level of trust and tolerance. American has strong emphasis on self-expression values. The self-expression value emphasis on high tolerance of gender equality, foreigners, homosexuality, high priority on decision-making participation in political and economic life and environment protection. On the contrary, survival value focus on low acceptance of outsiders with weak sense of happiness. Since US society policy makers always try to build civil society with rising individual agency, the society moves focus from survival value to self-expression value. Also, there are a few limitations with respect to the data analysis of World Value Survey. On the basis of this data analysis report, the analysis does not extend to other waves of survey. Moreover, the EDA and EFA sections do not seek to trace back to the older time for further US survey investigations. Discussion in this report would be more interesting if do further research and data analysis cross the countries.
                  ")
            )
          
            )
        
          ),
      
      
      tabItem(
        tabName = "result",
        fluidRow(
          box(
            title = "Conclusion",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = FALSE,
            print("The exploratory data analysis and exploratory factorial analysis on 2011 United States World Value Survey help demonstrate people’s points of view in economy, education, work, family, politics, culture, national identity, environment, gender equality, religion, security etc. It is essential to understand and appreciate their distinctive point of views. Culture zone pattern in the world based on value difference. Value difference include different senses of existential security and individual agency. For example, Protestant societies of Northern Europe has strong emphasis on the secular-rational values while Islamic societies of the Middle East focus on traditional values. Further data analysis on other countries surveys responses would help to test whether nowadays technological and economic changes would change people’s value and belief and help better understand the motivations for several particular upheaval all over the world, such as French civil unrest, Yugoslav wars., etc. ")
          )
        )
        
        
        
        
      ),
      
      tabItem(
        tabName = "explain",
        fluidRow(
          box(
            title = "Reference",
            width = 12,
            solidHeader = TRUE,
            status = "primary",
            collapsible = FALSE,
            print("Alesina, A; Giuliano, P; Nunn, N (2010), The Origins of Gender roles — Women and the Plough, World Values Survey. ")
          )
        )
      )
        )  
        )
      )
