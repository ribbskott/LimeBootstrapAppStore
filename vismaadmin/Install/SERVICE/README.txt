Installationsanvisning Visma Administration-integration (english below)

1. Skapa en mapp f�r installation (t.ex c:\VismaIntegration)
2. Skapa tv� undermappar, "bin" och "export"
3. Packa upp programfilerna till undermappen "bin"
4. Installera Pyton 3.4 som f�ljer med i paketet
5. Skapa en virtuel milj� i mappen som du skapade i punkt 1 (k�r cmd som administrat�r).
<<<<<<< HEAD
 * C:\VismaIntegration > c:\Python34\python.exe -m venv venv
=======
 * C:\VismaIntegration>c:\Python34\python.exe -m venv venv
>>>>>>> origin/master
6. Aktivera milj�n
 * C:\VismaIntegration > venv\Scripts\activate.bat
7. Installera Lime Pro API klienten fr�n PyPi
 * (venv) C:\VismaIntegration>pip install limeclient
(Mer information om installationen av Python och Import-api'et finns p� http://docs.lundalogik.com/pro/integration/import/api)
8. �ppna VismaIntegrationService.exe.config och g�r milj�inst�llningarna
 * VismaCommonPath = s�kv�g till Visma Gemensamma Filer-mappen (standards�kv�g redan ifylld)
 * VismaDbPath = s�kv�g till Visma F�retags-mappen (standards�kv�g redan ifylld)
 * ExportInvoiceHeadFile = s�kv�g till exportfilen f�r fakturahuvuden (standards�kv�g redan ifylld)
 * ExportInvoiceRowFile = s�kv�g till exportfilen f�r fakturarader (standards�kv�g redan ifylld)
 * ExportCustomerFinancialInfoFile = s�kv�g till exportfilen f�r oms�ttningstal f�r kund (standards�kv�g redan ifylld)
 * ExportCustomerFile = s�kv�g till exportfilen f�r kundmigrations-filen (standards�kv�g redan ifylld)
 * PythonExecutable = s�kv�g till python.exe i den virtuella milj�n som du satte upp i steg 5 (standards�kv�g redan ifylld)
 * LimeApiUri = s�kv�g till LIME Pro servern (se bilder f�r exempel b�de f�r on-premise och hosting-s�kv�g)
 * LimeApiDb = namn p� LIME Pro databas (skall vara tom om det �r en hosting installation)
 * LimeApiUser = namn p� den LIME Pro-anv�ndare som skall k�ra Python skriptet. Anv�ndaren skall ha skapats f�r installation av tj�nsten
 * LimeApiPassword = l�senord f�r den LIME Pro-anv�ndare som k�r python skriptet. Anv�ndaren skall ha skapats f�r installation av tj�nsten
9. Installera VismaIntegrationService.exe som Windows-tj�nst
 * start->run-> cmd.exe (h�gerklick, k�r som Admin)
 * C:\windows\microsoft.net\framework\v4.0.30319 > installutil c:\VismaIntegration\bin\VismaIntegrationService.exe
10. L�gg till VismaIntegrationService.exe i Windows-brandv�gg
 * Start->control panel->windows firewall->Allow an app or feature through Windows Firewall->F�lj guiden. 
11. Starta tj�nsten
 * Start->control panel->Administrative tools->Services->h�gerklick p� VismaIntegrationService, "run".
12. Kontrollera i programmets logg-fil (C:\VismaIntegration\bin\logg) att tj�nsten startat korrekt och kunde ansluta till Vismas API. 
13. F�rdig

----------- ENGLISH -------------- 
1. Create a folder for intallation (preferably c:\VismaIntegration)
2. Create two subfolders, "bin" and "export"
3. Unzip the programfiles to the folder "bin"
4. Install Python 3.4 (included in the installation package)
5. Create a virtual environment in the folder you created in step 1
 * C:\VismaIntegration>c:\Python34\python.exe -m venv venv
6. Activate the environment
 * C:\VismaIntegration>venv\Scripts\activate.bat
7. Install the LIME Pro API client from PyPi
 * (venv) C:\VismaIntegration>pip install limeclient
(More information regarding the installation of Python and the Import-API is available at http://docs.lundalogik.com/pro/integration/import/api)
8. Open the config-file VismaIntegrationService.exe.config and make the environnmental configurations
 * VismaCommonPath = path to the Visma Gemensamma Filer-folder (default path already suggested)
 * VismaDbPath = path to the Visma F�retags-folder (default path already suggested)
 * ExportInvoiceHeadFile = path to the exportfile for invoices (default path already suggested)
 * ExportInvoiceRowFile = path to the exportfile for invoicerows (default path already suggested)
 * ExportCustomerFinancialInfoFile =  path to the exportfile for turnover for customer (default path already suggested)
 * ExportCustomerFile =  path to the exportfile for customer migration (default path already suggested)
 * PythonExecutable = path to python.exe in the virtual environment that you cretaed in step 5 (default path already suggested)
 * InvoiceExportIntervalSeconds = how often the export of invoices from Visma should be done (default-value = 10)
 * LimeApiUri = path to the LIME Pro server used (see images for example for both on-premise as well as hosting paths)
 * LimeApiDb = name of the LIME Pro database connected (should be empty if hosting-installation)
 * LimeApiUser = name of the LIME Pro-user who runs the python script (as created prior to installing the service)
 * LimeApiPassword = password for the LIME Pro-user who runs the python script (as created prior to installing the service)
9. Install VismaIntegrationService.exe as a Windows-service
 * start->run-> cmd.exe (right click, run as administrator)
 * C:\windows\microsoft.net\framework\v4.0.30319>installutil c:\VismaIntegration\bin\VismaIntegrationService.exe
10. Add VismaIntegrationService.exe in Windows-firewall
 * Start->control panel->windows firewall->Allow an app or feature through Windows Firewall -> Follow the guide. 
11. Start the service
 * Start->control panel->Administrative tools->Services->right-click on VismaIntegrationService, "run".
12. Make sure that the program is running correctly and can connect to the Visma API by looking in the log-file (C:\VismaIntegration\bin\logg). 
13. Done