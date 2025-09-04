# Quarto Setup Guide for VS Code

## 1. Install Quarto Extension in VS Code
- Open VS Code
- Go to Extensions (Ctrl+Shift+X)
- Search for "Quarto" by Quarto Dev Team
- Click Install

## 2. Install Quarto CLI
- Visit https://quarto.org/docs/get-started/
- Download the installer for your operating system
- Run the installer and follow the setup wizard
- Verify installation by opening terminal and running: `quarto --version`

## 3. Install R Dependencies
Open R or RStudio and install required packages:
```r
install.packages(c("rmarkdown", "knitr"))
```

## 4. Create Your First Quarto Document
- In VS Code: File > New File
- Save as `example.qmd`
- Add basic YAML header:
```yaml
---
title: "My First Quarto Document"
format: html
---
```

## 5. Render and Preview
- Open Command Palette (Ctrl+Shift+P)
- Type "Quarto: Preview" and select it
- Or use terminal: `quarto preview example.qmd`
- Document will render and open in browser with live preview

## 6. Run Code Cells
Add R code blocks:
```r
# This is an R code cell
summary(cars)
plot(cars)
```
- Click the play button next to code blocks
- Or use Ctrl+Shift+Enter to run selected code
- Results appear inline

## 7. Edit Equations
Use LaTeX syntax for math:
```
Inline equation: $E = mc^2$

Display equation:
$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$
```

## 8. Additional Features
- **Tables**: Use markdown table syntax or `kable()` in R
- **Figures**: Code blocks automatically include plots
- **Citations**: Add bibliography with `bibliography: references.bib`
- **Cross-references**: Use `@fig-label` and `@tbl-label`

## Useful Commands
- `quarto render example.qmd` - Render to output format
- `quarto preview example.qmd` - Live preview mode
- `quarto create project` - Create new Quarto project

## Tips
- Use `#|` for cell options: `#| echo: false`, `#| warning: false`
- Combine multiple output formats in YAML: `format: [html, pdf, docx]`
- Use `freeze: true` in YAML to cache computations