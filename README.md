# fflib-apex-extensions Sample Code
Sample for the 
[fflib-apex-extensions](https://github.com/wimvelzeboer/fflib-apex-extensions/wiki).fflib-apex-extensions Library.  

**Dependencies:**<br/>
These samples are dependent on the following packages:
- [fflib-apex-mocks](https://github.com/apex-enterprise-patterns/fflib-apex-mocks)
- [fflib-apex-common](https://github.com/apex-enterprise-patterns/fflib-apex-common)
- [fflib-apex-extensions](https://github.com/wimvelzeboer/fflib-apex-extensions)

## Wiki
A full overview of all the features in fflib-apex-extensions can be found in 
[these Wiki pages](https://github.com/wimvelzeboer/fflib-apex-extensions/wiki).

## Installation
Use the following installation instructions for downloading the examples and installing them into a Scratch Org.

1. Download a copy of this repository
```shell
git clone https://github.com/wimvelzeboer/fflib-apex-extensions-samplecode.git
```

2. Create local project configuration
```shell
cd  fflib-apex-extensions-samplecode
cp ./dev-tools/templates/local-config-template.sh.ejs ./dev-tools/lib/local-config.sh
```
3. Edit the local project configurion file

Edit the file `./dev-tools/lib/local-config.sh` in your favorite TEXT editor.
Find the following settings and set it to the desired value

| Find Setting | Example | Notes | 
|:---|:---|:---
| DEV_HUB_ALIAS="<%%-userAnswers.devHubAlias%>" | DEV_HUB_ALIAS="MyDevHub" | Set this to the Alias of DevHub you authorised in your SFDX CLI
| SCRATCH_ORG_ALIAS="$NAMESPACE_PREFIX-SCRATCH" |SCRATCH_ORG_ALIAS="apex-ext-samples"| The Scratch Org alias to be created 

4. Execute the `rebuild-scratch-org` script 

The following command will execute the process to (re-)create a Scratch Org, install the dependencies and deploy the code examples.
After execution, check the listed configuration values and enter "YES" to confirm.
```shell
./dev-tools/rebuild-scratch-org
```

Have fun looking at the code and learning the patterns!

## Documentation
Do have a look at the 
[Wiki pages](https://github.com/wimvelzeboer/fflib-apex-extensions/wiki)
for a full overview of all the features in fflib-apex-extensions, 
or have a look at the  
[Method Reference](https://github.com/wimvelzeboer/fflib-apex-extensions/blob/main/docs/README.asciidoc)
documentation with explanations for all the methods.



