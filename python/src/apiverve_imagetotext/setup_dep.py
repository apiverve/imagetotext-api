from setuptools import setup, find_packages

setup(
    name='apiverve_imagetotext',
    version='1.2.3',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'requests',
        'setuptools'
    ],
    description='Image to Text is an OCR and image to text API that extracts text from image files or remote image URLs using optical character recognition. Upload a JPG, PNG, or GIF up to 5 MB to receive the raw extracted text.',
    author='APIVerve',
    author_email='hello@apiverve.com',
    url='https://apiverve.com/marketplace/imagetotext?utm_source=pypi&utm_medium=referral&utm_content=homepage',
    classifiers=[
        'Programming Language :: Python :: 3',
        'Operating System :: OS Independent',
    ],
    python_requires='>=3.6',
)
