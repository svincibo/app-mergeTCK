[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
mergeTCK: [![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.219-blue.svg)](https://doi.org/10.25663/brainlife.app.219)
merge2TCKs: [![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.304-blue.svg)](https://doi.org/10.25663/brainlife.app.304)

# app-mergeTCK
Merge multiple TCK files into one TCK file.

### Author
- Sophia Vinci-Booher (svincibo@indiana.edu)

### Contributor
- Soichi Hayashi (hayashis@iu.edu)

### Project director
- Franco Pestilli (franpest@indiana.edu)

### Funding 
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-SMA-2004877](https://img.shields.io/badge/NSF_SMA-2004877-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=2004877)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)
[![NIH-T32-HD007475](https://img.shields.io/badge/NIH_T32-HD007475-green.svg)](https://www.nichd.nih.gov/grants-contracts/training-careers/extramural/institutional)

### Citations

We kindly ask that you cite the following articles when publishing papers and code using this code.

Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). https://doi.org/10.1038/s41597-019-0073-y

MIT Copyright (c) 2020 brainlife.io The University of Texas at Austin and Indiana University

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/brainlife.app.304](https://doi.org/10.25663/brainlife.app.304) for merge2TCKS and [https://doi.org/10.25663/brainlife.app.219](https://doi.org/10.25663/brainlife.app.219) for mergeTCK via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
        "tcks": ["./track1.tck", "./track2.tck", "./track3.tck"]
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Sample Datasets

If you don't have your own input file, you can download sample datasets from Brainlife.io, or you can use [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5c0c5d8df6f108004b490ec8 && mv 5c0c5d8df6f108004b490ec8 input/track
bl dataset download 5c0c5e17f6f108004b490ecb && mv 5c0c5e17f6f108004b490ecb input/track
bl dataset download 5c0c5faff6f108004b490ed8 && mv 5c0c5faff6f108004b490ed8 input/track

```

## Output

All output files will be generated under the current working directory (pwd). The main output of this App is a file called `track.tck`. This file contains following object.

```
tck = 

    name: 'track'

```

### Dependencies

This App requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.  

  - Matlab: https://www.mathworks.com/products/matlab.html
  - jsonlab: https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files
  - VISTASOFT: https://github.com/vistalab/vistasoft/
  - MRTRIX3: https://www.mrtrix.org/

