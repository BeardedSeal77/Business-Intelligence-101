# R in Jupyter Notebooks Installation Guide (Windows)

This guide will walk you through setting up R to work in Jupyter notebooks on Windows.

## Step 1: Check if Jupyter is Already Installed

First, check if Jupyter is already installed on your machine:
```
where jupyter
jupyter kernelspec list
```

If Jupyter is not installed, install it:

1. Download Python from https://python.org/downloads/
2. During installation, check "Add Python to PATH"
3. Open Command Prompt and install Jupyter:
   ```
   pip install jupyter
   ```
4. Verify installation:
   ```
   jupyter --version
   where jupyter
   ```

## Step 2: Install R

1. Download R from https://cran.r-project.org/bin/windows/base/
2. Run the installer with default settings
3. During installation, ensure "Add R to system PATH" is checked
4. Verify installation by opening Command Prompt and typing:
   ```
   R --version
   ```

## Step 3: Install IRkernel (run in admin console)

Run this single command in an admin Command Prompt:
```
R -e "install.packages('IRkernel', repos='https://cloud.r-project.org/'); IRkernel::installspec(user = FALSE)"
```

## Step 4: Verify Everything Works

1. Start Jupyter:
   ```
   jupyter notebook
   ```

2. Create a new notebook and check if "R" appears in the kernel options

3. In an R notebook cell, test:
   ```r
   print("Hello from R!")
   plot(1:10)
   ```

## Troubleshooting

### R kernel not appearing in Jupyter
- Restart Jupyter after installing IRkernel
- Try installing with `user = FALSE` option
- Check R installation path is in system PATH

### Permission errors
- Run Command Prompt as Administrator
- Install packages to user library instead

### Path issues
- Ensure both R and Python are in system PATH
- Add to PATH: `C:\Program Files\R\R-x.x.x\bin`
- Restart terminal after PATH changes

### Package installation fails
```r
# If CRAN mirrors fail, try different mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))
install.packages('IRkernel')
```

## Verification Commands

Test your installation with these commands:

```bash
# Check Python
python --version

# Check Jupyter
jupyter --version

# Check R
R --version

# List Jupyter kernels
jupyter kernelspec list
```

You should see both `python3` and `ir` kernels listed.