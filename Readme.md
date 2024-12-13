# Manta SV Caller (DNAnexus Platform App)

This app runs dockerised Manta (version 1.6.0) https://github.com/Illumina/manta.

## Build app in a DNAnexus project
1. Clone **eg_manta** repoistory from github
2. Build app in DNAnexus `dx build eg_manta -d <project-id>:<directory>`

## Run app
### GUI
1. Find and run the compiled app in the project and direcotry specified in build.
2. Select a single samples paired **.bam** and **.bai** file for the `bams` input field.
3. Specify the family and sample number. This will be used to add a prefix to the output file names.

### Command line
1. Generate **input.json** using the structure below.
```
{
    "bams": [
        {
            "$dnanexus_link": "<bam_file_id>"
        },
        {
            "$dnanexus_link": "<bai_file_id>"
        }
    ],
    "family_number": "e.g F09999",
    "sample_number": "e.g. EX1234567"
    "options": "e.g. --callRegions region.bed.gz --generateEvidenceBam"
}
```
2. Run the app \
`dx run <app_id> -f <input.json> --destination <output_project-id>:<output_dir --tag <optional_description> -y`

### Options

`--callRegions <region.bed.gz>` - Specify genomic region in bgzip-compressed and tabix-indexed file. \
`--generateEvidenceBam` - Generates bam files from SVs listed in candidate VCF file. Use `--region <chr20:1000-2000>` to specify restricted genomic regions.



