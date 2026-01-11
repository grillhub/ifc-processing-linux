# BIM IFC Processing Backend

A Unity Engine-based backend service for processing Building Information Modeling (BIM) IFC (Industry Foundation Classes) files and converting them to JSON format (BDMJson) for 3D model generation pipelines.

## Overview

This backend service is developed using **Unity Engine** and is designed to run on **Linux dedicated servers**. It processes BIM IFC extension files and converts them to JSON format, specifically the **BDMJson** format as described in the research paper: [Building Data Model JSON (BDMJson)](https://dl.acm.org/doi/10.1145/3775050.3775051).

The generated JSON files are then used by another pipeline to create 3D models, enabling a complete workflow from IFC files to interactive 3D visualizations.

## Architecture

### Technology Stack
- **Runtime Engine**: Unity Engine (headless/server build)
- **Target Platform**: Linux (dedicated server)
- **IFC Processing**: IfcOpenShell (IfcConvert)
- **HTTP Server**: Built-in HTTP listener for REST API
- **Data Format**: JSON (BDMJson schema)

### Processing Pipeline

The backend follows a multi-stage processing pipeline:

1. **IFC File Reception**: Receives IFC files via HTTP POST requests
2. **IFC Conversion**: Uses IfcOpenShell to convert IFC files to intermediate formats:
   - `.obj` (Wavefront OBJ) - High LOD geometry
   - `.glb` (GLTF Binary) - Low LOD geometry for web viewing
   - `.xml` (IFC XML) - Metadata extraction
   - `.dae` (Collada) - Alternative geometry format
3. **Unity Object Processing**: Converts geometry to Unity-compatible formats
4. **JSON Generation**: Creates multiple JSON outputs:
   - `.jsonbrick` - Brick schema representation
   - `.jsonproperties` - IFC element properties
   - `.jsonobject` - Unity object structure
   - `.jsonchunk` - Chunked data for large models
5. **Chunking**: Splits large models into manageable chunks for efficient loading
6. **Thumbnail Generation**: Creates preview images for visualization
7. **Output Delivery**: Provides processed files for downstream 3D model generation

## Features

### Multi-LOD Processing
- **High LOD**: Detailed geometry with full IFC properties
- **Low LOD**: Optimized geometry for web viewing
- **Space LOD**: Spatial relationships and room data

### Output Formats
- **Geometry**: OBJ, GLB, DAE formats
- **Metadata**: XML, JSON properties
- **Structured Data**: BDMJson format with Brick schema support
- **Chunked Data**: JSON chunks for progressive loading
- **Visualizations**: Thumbnail images

### HTTP API

## API Endpoints

### POST `/api/process-ifc`
Process an IFC file and generate all output formats.

**Request Parameters:**
- `file` (file): The IFC file to process (required)
- `buildingId` (string): Unique building identifier (required)
- `description` (string): Description of the building (optional)
- `userId` (string): User identifier (optional)
- `selectedLOD` (string): Level of detail options (optional)
- `csvFile*` (file): Optional CSV files for data enrichment

### GET `/api/status`
Get server status and available endpoints.

### GET `/api/status/{processingId}`
Check the status of a specific processing job.

## Installation & Deployment

### Build for Linux Server

1. **Configure Build Settings**:
   - Target Platform: Linux
   - Server Build: Enabled (headless)
   - Architecture: x86_64

2. **Build the Project**:
   ```
   File → Build Settings → Linux → Build
   ```

3. **Deploy to Server**:
   - Copy the built executable and data folder to the Linux server
   - Ensure `IfcConvert` binary is in the `Assets/` directory
   - Set executable permissions: `chmod +x server.x86_64`

4. **Run the Server**:
   ```bash
   ./server.x86_64
   ```

## BDMJson Format

The backend generates JSON files in the **BDMJson** (Building Data Model JSON) format, which is based on the research paper:

> **Reference**: [Building Data Model JSON (BDMJson)](https://dl.acm.org/doi/10.1145/3775050.3775051)

The BDMJson format includes:
- **Brick Schema**: Semantic building data representation
- **IFC Properties**: Extracted IFC element properties
- **Geometry References**: Links to geometry files
- **Hierarchical Structure**: Building → Floor → Space → Element relationships

## Research Reference

This project implements the BDMJson format as described in:

**Title**: Building Data Model JSON (BDMJson)  
**DOI**: [10.1145/3775050.3775051](https://dl.acm.org/doi/10.1145/3775050.3775051)  
**ACM Digital Library**: https://dl.acm.org/doi/10.1145/3775050.3775051

