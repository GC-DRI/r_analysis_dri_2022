Regression Warm-up
================

This section is part of the R Data Analysis Workshop and aims to
introduce some basic concepts for regression analysis in R. If you want
to learn more in details, I would recommend you read the [Introduction
to Econometrics with R](https://www.econometrics-with-r.org/index.html),
a free e-book.

## Variable Types

- Discrete: A discrete variable is a variable whose value is obtained by
  counting. Examples: number of students present.

- Continuous: A continuous variable is a variable whose value is
  obtained by measuring, i.e., one which can take on an uncountable set
  of values.

- Binary: Binary variables are variables which only take two values. For
  example, Male or Female, True or False and Yes or No. You can also
  construct a binary variable for age like Adult ($>18$ yrs old) or
  Non-Adult ($<18$ yrs old).

- Categorical: Categorical variables represent types of data which may
  be divided into groups. Examples of categorical variables are race,
  sex, age group, and educational level.

## Why Regression Analysis?

Regression analysis is a statistical technique for studying linear
relationships. Typically, a regression analysis is done for one of two
purposes: In order to predict the value of the dependent variable for
individuals for whom some information concerning the explanatory
variables is available, or in order to estimate the effect of some
explanatory variable on the dependent variable.

- Making individual predictions. If we know the value of several
  explanatory variables for an individual, but do not know the value of
  that individual’s dependent variable, we can use the prediction
  equation to estimate the value of the dependent variable for that
  individual.

- Estimating the effect of an explanatory variable on the dependent
  variable. In order to estimate the “pure” effect of some explanatory
  variable on the dependent variable, we want to control for as many
  other effects as possible. That is, we’d like to see how our
  prediction would change for an individual if this explanatory variable
  were different, while all others aspects of the individual were kept
  the same.

- Determining whether there is evidence that an explanatory variable
  belongs in a regression model. Given a specific model, one might
  wonder whether a particular one of the explanatory variables really
  “belongs” in the model; equivalently, one might ask if this variable
  has a true regression coefficient different from 0 (and therefore
  would affect predictions).

- Measuring the explanatory power of a model.
  [(Reference)](https://www.kellogg.northwestern.edu/faculty/weber/jhu/statistics/regression.htm)

## Key Terms in Regression Model

- Correlation: is a statistic that measures the degree to which two
  variables move in relation to each other. Or a statistical
  relationship, whether causal or not, between two random variables or
  bivariate data.

- Independent/explanatory variable (predictor): the cause. Its value is
  independent of other variables in the model.

  - In experiment, the independent variable is the treatment that varies
    between groups, e.g., which type of pill the patient receives.

- Dependent/response variable: the effect. Its value depends on changes
  in the independent variable(s).

  - In experiment, the dependent variable is the outcome being measured,
    e.g., the blood pressure of the patients.

  - In other types of research, researchers have to find
    already-existing examples of the independent variable, and
    investigate how changes in this variable affect the dependent
    variable.

- Regression coefficient: in a regression analysis, the weight
  associated with a unit change in a specific independent (predictor)
  variable on the dependent (outcome) variable, given the relationship
  of that predictor to other independent variables already in the model.

## Assumptions of Multiple Linear Regression

Multiple linear regression analysis makes several key assumptions:

- There must be a linear relationship between the outcome variable and
  the independent variables. Scatterplots can show whether there is a
  linear or curvilinear relationship.

- Multivariate Normality: Multiple regression assumes that the residuals
  are normally distributed.

- No Multicollinearity: Multiple regression assumes that the independent
  variables are not highly correlated with each other. This assumption
  can be tested with Variance Inflation Factor (VIF) values.

- Homoscedasticity: This assumption states that the variance of error
  terms are similar across the values of the independent variables. A
  plot of standardized residuals versus predicted values can show
  whether points are equally distributed across all values of the
  independent variables.

Moreover, multiple linear regression requires at least two explanatory
variables, which can be nominal, ordinal, or interval/ratio level
variables. A rule of thumb for the sample size is at least 20 cases per
independent variable in the analysis.

## Regression Tests

- VIF: Variation inflation factor (VIF) quantifies how much the variance
  is inflated. The variances of the estimated coefficients are inflated
  when multicollinearity exists and a variance inflation factor exists
  for each of the predictors in the model. How do we interpret the
  variance inflation factors for a regression model? A VIF of 1 means
  that there is no correlation among the jth predictor and the remaining
  predictor variables, and hence the variance of bj is not inflated at
  all. The rule of thumb is that VIFs exceeding 4 warrant further
  investigation, while VIFs exceeding 10 are signs of serious
  multicollinearity.

- Cook’s Distance: Cook’s distance measures how much all of the fitted
  values in the model change when the ith data point is deleted and is
  useful for identifying influential data points and outliers in the X
  values. A general rule of thumb is that any point with a Cook’s
  distance over 4/n (where n is the number of observations) is
  considered to be an outlier. Please note that just because a data
  point is influential doesn’t mean it should necessarily be deleted.
  More details
  [here](https://www.statology.org/how-to-identify-influential-data-points-using-cooks-distance/).

- Leverage: Leverage is a measure of how far away the independent
  variable values of an observation are from those of the other
  observations. High-leverage points, if any, are outliers with respect
  to the independent variables. hat is, high-leverage points have no
  neighboring points in $R^p$ space, where $p$ is the number of
  independent variables in a regression model. This makes the fitted
  model likely to pass close to a high leverage observation. Hence
  high-leverage points have the potential to cause large changes in the
  parameter estimates when they are deleted i.e., to be influential
  points. Although an influential point will typically have high
  leverage, a high leverage point is not necessarily an influential
  point.
  [Reference:Wiki](https://en.wikipedia.org/wiki/Leverage_(statistics))

## Regression Performance

- R-squared: R-squared ($R^2$) is a statistical measure that represents
  the proportion of the variance for a dependent variable that’s
  explained by an independent variable or variables in a regression
  model.

  - In short, larger R-squared means the independent variables can
    explain more proportion of the variance for the dependent variable.
  - Math detail is
    [here](https://en.wikipedia.org/wiki/Coefficient_of_determination).

- AIC (Akaike Information Criterion): AIC is an estimator of
  out-of-sample prediction error and thereby relative quality of
  statistical models for a given set of data. Given a collection of
  models for the data, AIC estimates the quality of each model, relative
  to each of the other models. Thus, AIC provides a means for model
  selection.

  - AIC is typically used when you do not have access to out-of-sample
    data and want to decide between multiple different model types, or
    for time convenience.
  - The preferred model is the one with the lowest AIC value. The AIC
    methodology attempts to find the model that best explains the data
    with a minimum of free parameters.
  - Mathematical detail is
    [here](https://en.wikipedia.org/wiki/Akaike_information_criterion).

- BIC (Bayesian Information Criterion): BIC is a criterion for model
  selection among a finite set of models. It is based, in part, on the
  likelihood function, and it is closely related to AIC.

  - When fitting models, it is possible to increase the likelihood by
    adding parameters, but doing so may result in overfitting. The BIC
    resolves this problem by introducing a penalty term for the number
    of parameters in the model. The penalty term is larger in BIC than
    in AIC.
  - When picking from several models, ones with lower BIC value is
    preferred.
  - Mathematical detail is
    [here](https://www.immagic.com/eLibrary/ARCHIVES/GENERAL/WIKIPEDI/W120607B.pdf).

## Hypothesis Testing

- Null hypothesis ($H_0$): The statement being tested in a test of
  statistical significance is called the null hypothesis. The test of
  significance is designed to assess the strength of the evidence
  against the null hypothesis. Usually, the null hypothesis is a
  statement of ‘no effect’ or ‘no difference’.” Ex.,
  $H_0: \mu_1 = \mu_2$

- Alternative hypothesis ($H_1$): The statement that is being tested
  against the null hypothesis is the alternative hypothesis. Ex.,
  $H_1: \mu_1 \neq \mu_2$

- Test statistic: A test statistic is a statistic (a quantity derived
  from the sample) used in statistical hypothesis testing. Two widely
  used test statistics are the t-statistic and the F-test. More details
  [here](https://en.wikipedia.org/wiki/Test_statistic).

- P-value: **P-value** is the probability of obtaining test results at
  least as extreme as the results actually observed, under the
  assumption that the null hypothesis is correct.

  - A very small p-value means that such an extreme observed outcome
    would be very unlikely under the null hypothesis.
  - Reporting p-values of statistical tests is common practice in
    academic publications of many quantitative fields. Since the precise
    meaning of p-value is hard to grasp, [misuse is
    widespread](https://en.wikipedia.org/wiki/Misuse_of_p-values) and
    has been a major topic in
    [metascience](https://en.wikipedia.org/wiki/Metascience).

- Significance level for the test ($\alpha$): is the probability of
  rejecting the null hypothesis when it is true. For example, a
  significance level of 0.05 indicates a 5% risk of concluding that a
  difference exists when there is no actual difference. More detail is
  [here](https://blog.minitab.com/en/adventures-in-statistics-2/understanding-hypothesis-tests-significance-levels-alpha-and-p-values-in-statistics).

[Next: Regression Analysis
\>\>\>](https://github.com/YuxiaoLuo/r_analysis_dri_2022/blob/main/regression_analysis.md)
