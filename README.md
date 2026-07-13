# Type I and Type II Errors Interactive Tool

An interactive **R Shiny** application for visualizing Type I error, Type II error, statistical power, critical values, and the effect of changing the significance level and effect size in one-tailed and two-tailed hypothesis tests.

The tool is designed for students, instructors, researchers, and anyone who wants an intuitive visual explanation of hypothesis-testing errors.

## Application

[Launch the interactive tool](https://xxdm9u-namit-choudhari.shinyapps.io/type1-type2-error-tool/)


---

## Table of Contents

- [Introduction](#introduction)
- [What Are Type I and Type II Errors?](#what-are-type-i-and-type-ii-errors)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Setup and Installation](#setup-and-installation)
- [How to Use the Tool](#how-to-use-the-tool)
- [Statistical Assumptions](#statistical-assumptions)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Suggested Future Enhancements](#suggested-future-enhancements)
- [License](#license)
- [Author and Contact](#author-and-contact)
- [Acknowledgments](#acknowledgments)

---

## Introduction

Type I and Type II errors are fundamental concepts in statistical hypothesis testing, but the trade-off between the two types of errors is often difficult to understand from their formulas alone.

This application provides an interactive visual demonstration using two standard normal distributions:

- The **null-hypothesis distribution**, \(H_0\)
- The **alternative-hypothesis distribution**, \(H_1\)

Users can adjust the significance level and effect size and immediately observe how these choices influence:

- Type I error, \(\alpha\)
- Type II error, \(\beta\)
- Statistical power, \(1-\beta\)
- Critical values
- Rejection and non-rejection regions
- The difference between one-tailed and two-tailed tests

---

## What Are Type I and Type II Errors?

### Type I Error

A **Type I error** occurs when the null hypothesis is rejected even though it is true.

\[
\text{Type I Error} = P(\text{Reject } H_0 \mid H_0 \text{ is true}) = \alpha
\]

Example: Concluding that a treatment is effective when it actually has no effect.

The significance level, \(\alpha\), controls the probability of making a Type I error.

### Type II Error

A **Type II error** occurs when the null hypothesis is not rejected even though the alternative hypothesis is true.

\[
\text{Type II Error} = P(\text{Fail to reject } H_0 \mid H_1 \text{ is true}) = \beta
\]

Example: Concluding that there is insufficient evidence of a treatment effect when a real effect actually exists.

### Statistical Power

Statistical power is the probability of correctly rejecting the null hypothesis when the alternative hypothesis is true.

\[
\text{Power} = 1-\beta
\]

Higher power means that a statistical test is more likely to detect a real effect.

---

## Features

- Interactive one-tailed and two-tailed hypothesis tests
- Adjustable significance level, \(\alpha\)
- Adjustable effect size, \(\mu_1-\mu_0\)
- Dynamic Type I error visualization
- Dynamic Type II error visualization
- Automatic statistical-power calculation
- Interactive Plotly graph with hover information
- Display of one or two critical values depending on the selected test
- Responsive browser-based layout
- Educational explanations and interpretation guidance
- Deployable through shinyapps.io

---

## Technology Stack

- **R**
- **Shiny**
- **Plotly**
- **HTML**
- **CSS**
- **JavaScript**
- **rsconnect** for deployment

---

## Project Structure

```text
type1-type2-error-tool/
├── app.R
├── README.md
├── LICENSE
├── .gitignore
└── screenshots/
    └── application-preview.png
```

Only `app.R` is required to run the application. The additional files are recommended for a professional GitHub repository.

---

## Setup and Installation

### 1. Install R

Download and install a recent version of R from the Comprehensive R Archive Network.

### 2. Install RStudio

RStudio is recommended as the development environment for running and editing the application.

### 3. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY-NAME.git
cd YOUR-REPOSITORY-NAME
```

Replace `YOUR-USERNAME` and `YOUR-REPOSITORY-NAME` with the correct GitHub account and repository names.

### 4. Install the required R packages

Open R or RStudio and run:

```r
install.packages(c(
  "shiny",
  "plotly"
))
```

Install `rsconnect` only when deployment to shinyapps.io is needed:

```r
install.packages("rsconnect")
```

### 5. Run the application

From the repository directory, run:

```r
library(shiny)
runApp()
```

Alternatively, provide the full path to the application folder:

```r
library(shiny)

runApp(
  "C:/path/to/type1-type2-error-tool"
)
```

The application should open in the RStudio Viewer or your default web browser.

---

## How to Use the Tool

### Step 1: Select the test type

Choose one of the following:

- **One-Tailed (Right):** Tests for an effect in the positive direction.
- **Two-Tailed:** Tests for an effect in either direction.

### Step 2: Adjust the significance level

Use the **Significance Level (\(\alpha\))** slider.

A lower significance level makes it more difficult to reject the null hypothesis and reduces the probability of a Type I error.

### Step 3: Adjust the effect size

Use the **Effect Size (\(\mu_1-\mu_0\))** slider.

A larger effect size separates the null and alternative distributions, generally decreasing Type II error and increasing statistical power.

### Step 4: Interpret the graph

- **Blue curve:** Null-hypothesis distribution, \(H_0\)
- **Red curve:** Alternative-hypothesis distribution, \(H_1\)
- **Blue shaded region:** Type I error
- **Red shaded region:** Type II error
- **Black dashed line or lines:** Critical value or critical values

### Step 5: Review the calculated statistics

The cards below the graph display:

- Type I error, \(\alpha\)
- Type II error, \(\beta\)
- Statistical power, \(1-\beta\)

### Step 6: Explore the interactive graph

Hover over the curves and shaded regions to inspect test-statistic values and probability densities.

---

## Statistical Assumptions

The current version uses the following assumptions:

- The null distribution is standard normal:
  \[
  H_0 \sim N(0,1)
  \]
- The alternative distribution has:
  \[
  H_1 \sim N(\mu_1,1)
  \]
- Both distributions have equal standard deviation:
  \[
  \sigma=1
  \]
- The effect size is represented as:
  \[
  \mu_1-\mu_0
  \]
- The one-tailed test is right-tailed.
- The two-tailed test divides the significance level equally between both tails.

This tool is intended primarily for education and demonstration. It does not replace a complete power or sample-size analysis for a specific research design.

---

## Deployment

### Deploy to shinyapps.io

First, create a shinyapps.io account and obtain an account token.

Register the account in R:

```r
library(rsconnect)

rsconnect::setAccountInfo(
  name = "YOUR-ACCOUNT-NAME",
  token = "YOUR-TOKEN",
  secret = "YOUR-SECRET"
)
```

Do not commit tokens or secrets to GitHub.

Deploy the application:

```r
library(rsconnect)

rsconnect::deployApp(
  appDir = "path/to/type1-type2-error-tool",
  appName = "type1-type2-error-tool"
)
```

The deployment command should be run from the R console. It should not be placed inside `app.R`.

### Redeploy after updates

After editing and saving `app.R`, run:

```r
rsconnect::deployApp(
  appDir = "path/to/type1-type2-error-tool",
  appName = "type1-type2-error-tool",
  forceUpdate = TRUE
)
```

---

## Troubleshooting

### Error: `App dir must contain either app.R or server.R`

Confirm that:

- The application file is named exactly `app.R`
- `app.R` is inside the folder passed to `runApp()`
- Windows has not renamed the file to `app.R.R` or `app.R.txt`

Check the folder contents in R:

```r
list.files("path/to/type1-type2-error-tool")
```

### Error: `No accounts registered`

Register the shinyapps.io account using:

```r
rsconnect::setAccountInfo(
  name = "YOUR-ACCOUNT-NAME",
  token = "YOUR-TOKEN",
  secret = "YOUR-SECRET"
)
```

Verify the account:

```r
rsconnect::accounts()
```

### Application deploys but does not start

Inspect the server logs:

```r
rsconnect::showLogs(
  appName = "type1-type2-error-tool",
  account = "YOUR-ACCOUNT-NAME",
  streaming = FALSE
)
```

Also confirm that `app.R` ends with:

```r
shinyApp(ui = ui, server = server)
```

Do not keep `rsconnect::deployApp()` inside `app.R`.

### Package-version warnings

Warnings such as the following are usually not fatal:

```text
package 'shiny' was built under R version ...
```

They indicate that a package was built under a slightly different R version. Update or reinstall the package if the application does not run correctly.

---

## Contributing

We welcome contributions to improve this project. To contribute:

To contribute:

1. Fork the repository.
2. Clone your fork:

   ```bash
   git clone https://github.com/YOUR-USERNAME/YOUR-FORK.git
   ```

3. Create a new branch:

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. Make your changes.
5. Test the application locally:

   ```r
   shiny::runApp()
   ```

6. Commit your changes:

   ```bash
   git add .
   git commit -m "Add a clear description of the change"
   ```

7. Push the branch:

   ```bash
   git push origin feature/your-feature-name
   ```

8. Open a pull request.
9. Describe:
   - What was changed
   - Why the change was needed
   - How the change was tested
   - Any screenshots or examples relevant to the change

### Contribution Guidelines

- Keep the code readable and well documented.
- Do not commit API keys, tokens, passwords, or secrets.
- Test both one-tailed and two-tailed modes.
- Confirm that the application remains responsive on desktop and mobile screens.
- Update the README when new functionality is introduced.
- Use clear commit messages.
- Keep pull requests focused on one main change whenever possible.
- Report major bugs through GitHub Issues before submitting a large fix.

---

## Suggested Future Enhancements

Potential improvements include:

- Left-tailed test support
- User-defined null and alternative means
- User-defined standard deviations
- Power/sample-size inputs and calculations
- Student's t-distribution support
- Additional statistical tests
- Downloadable graph and results
- Dark mode
- Accessibility improvements
- Mobile-app or progressive-web-app version
- Automated tests

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---

## Author and Contact

**Namit Choudhari**

For questions, suggestions, or collaboration requests, open a GitHub Issue or use the contact information listed in the GitHub profile associated with this repository.

---

## Acknowledgments

This project uses:

- R Shiny for the interactive web-application framework
- Plotly for interactive statistical visualization
- The R statistical-computing environment for probability calculations

The application was developed as an educational tool to improve understanding of hypothesis testing, statistical errors, and power.
